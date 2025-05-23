figma.showUI(__html__, { width: 800, height: 600 });

let currentTextNode: TextNode | null = null;
let copiedVariable: Variable | null = null; // Store the copied variable

// Function to handle selection changes
function handleSelectionChange() {
  const selection = figma.currentPage.selection;
  if (selection.length === 1 && selection[0].type === "TEXT") {
    currentTextNode = selection[0] as TextNode;
    updateCurrentMapping();
  } else {
    currentTextNode = null;
    figma.ui.postMessage({
      type: "update-current-mapping",
      data: {
        mapping: null,
        message:
          "Please select a single text node to view or apply variable mappings.",
      },
    });
  }
}

// Update current mapping in the UI
async function updateCurrentMapping() {
  if (!currentTextNode) {
    notifyUI("No text node is selected.");
    return;
  }

  const boundVariable = currentTextNode.boundVariables?.characters;
  if (!boundVariable) {
    notifyUI("No variable is bound to this text node.");
    return;
  }

  const variable = await figma.variables.getVariableByIdAsync(boundVariable.id);
  if (!variable || variable.resolvedType !== "STRING") {
    notifyUI("The bound variable is not of type STRING.");
    return;
  }

  const collection = await figma.variables.getVariableCollectionByIdAsync(
    variable.variableCollectionId
  );
  if (!collection || collection.modes.length === 0) {
    notifyUI("The variable's collection has no modes or is invalid.");
    return;
  }

  const defaultModeId = collection.modes[0].modeId;
  figma.ui.postMessage({
    type: "update-current-mapping",
    data: {
      mapping: {
        colllectionName: collection.name,
        id: variable.id,
        name: variable.name,
        value: variable.valuesByMode[defaultModeId],
      },
      message: "Variable mapping updated successfully.",
    },
  });
}

function notifyUI(message: string) {
  figma.ui.postMessage({
    type: "update-current-mapping",
    data: { mapping: null, message },
  });
}

// Copy the variable bound to the selected text node
async function copyVariable() {
  if (!currentTextNode) {
    figma.ui.postMessage({
      type: "toast",
      data: { message: "No valid text node is selected to copy a variable.", success: false },
    });
    return;
  }

  const boundVariable = currentTextNode.boundVariables?.characters;
  if (!boundVariable) {
    figma.ui.postMessage({
      type: "toast",
      data: { message: "No variable is bound to the selected text node.", success: false },
    });
    return;
  }

  const variable = await figma.variables.getVariableByIdAsync(boundVariable.id);
  if (variable && variable.resolvedType === "STRING") {
    copiedVariable = variable; // Store the copied variable
    // figma.ui.postMessage({
    //   type: "toast",
    //   data: { message: `Variable "${variable.name}" copied successfully!`, success: true },
    // });
  } else {
    figma.ui.postMessage({
      type: "toast",
      data: { message: "The bound variable is not of type STRING or does not exist.", success: false },
    });
  }
}

// Paste the copied variable to the selected text node
async function pasteVariable() {
  if (!currentTextNode) {
    figma.ui.postMessage({
      type: "toast",
      data: { message: "No valid text node is selected to paste a variable.", success: false },
    });
    return;
  }

  if (!copiedVariable) {
    figma.ui.postMessage({
      type: "toast",
      data: { message: "No variable has been copied. Use Cmd + Shift + < to copy a variable first.", success: false },
    });
    return;
  }

  // Bind the copied variable to the current text node
  currentTextNode.setBoundVariable("characters", copiedVariable);
  // figma.ui.postMessage({
  //   type: "toast",
  //   data: { message: `Variable "${copiedVariable.name}" pasted successfully!`, success: true },
  // });
}

// Fetch collections and send to UI
async function fetchCollections() {
  const collections = await figma.variables.getLocalVariableCollectionsAsync();
  figma.ui.postMessage({
    type: "update-collections",
    data: { collections: collections.map((c) => ({ id: c.id, name: c.name })) },
  });
}

// Fetch variables for a collection and send to UI
async function fetchVariables(collectionId: string) {
  const collection = await figma.variables.getVariableCollectionByIdAsync(
    collectionId
  );

  if (collection) {
    const defaultModeId = collection.modes[0].modeId;

    // Fetch all variables in the collection
    const variables = await Promise.all(
      collection.variableIds.map((id) =>
        figma.variables.getVariableByIdAsync(id)
      )
    );

    // Get the bound variable ID from the selected text node
    const boundVariableId = currentTextNode?.boundVariables?.characters?.id;

    // Filter variables to include only those of type 'STRING'
    const stringVariables = variables.filter(
      (variable) => variable?.resolvedType === "STRING"
    );

    // Send the filtered variables to the UI
    figma.ui.postMessage({
      type: "update-variables",
      data: {
        variables: stringVariables.map((variable) => ({
          id: variable!.id,
          name: variable!.name,
          value: String(variable!.valuesByMode[defaultModeId]), // Convert value to string
          isMapped: variable!.id === boundVariableId,
        })),
      },
    });
  }
}

// Apply variable to the selected text node
async function applyVariable(variableId: string) {
  if (!currentTextNode) {
    // Notify the user if no valid text node is selected
    figma.ui.postMessage({
      type: "toast",
      data: { message: "No valid text node is selected. Please select a text node.", success: false },
    });
    return;
  }

  const variable = await figma.variables.getVariableByIdAsync(variableId);
  if (variable && variable.resolvedType === "STRING") {
    // Bind the variable to the text node
    currentTextNode.setBoundVariable("characters", variable);

    // Notify the user via a toast message and indicate success
    figma.ui.postMessage({
      type: "toast",
      data: { message: "Variable successfully bound to the text node!", success: true },
    });
  } else {
    // Notify the user if the variable is not of type STRING or does not exist
    figma.ui.postMessage({
      type: "toast",
      data: { message: "Variable is not of type STRING or does not exist.", success: false },
    });
  }
}

// Export collection to CSV
async function exportCollectionToCSV(collectionId: string) {
  const collection = await figma.variables.getVariableCollectionByIdAsync(collectionId);

  if (!collection) {
    figma.ui.postMessage({
      type: "toast",
      data: { message: "Collection not found.", success: false },
    });
    return;
  }

  const variables = await Promise.all(
    collection.variableIds.map((id) => figma.variables.getVariableByIdAsync(id))
  );

  const csvRows = [
    ["Variable Name", "Mode Name", "Variable Value", "Variable ID"], // Header row
  ];

  collection.modes.forEach((mode) => {
    variables.forEach((variable) => {
      if (variable && variable.resolvedType === "STRING") {
        const value = variable.valuesByMode[mode.modeId] || "";
        csvRows.push([variable.name, mode.name, String(value), variable.id]);
      }
    });
  });

  // Convert rows to CSV format
  const csvContent = csvRows.map((row) => row.join(",")).join("\n");

  // Send the CSV data back to the UI
  figma.ui.postMessage({
    type: "export-csv",
    data: { csvContent, collectionName: collection.name },
  });
}

// Export collection to JSON
async function exportCollectionToJSON(collectionId: string) {
  const collection = await figma.variables.getVariableCollectionByIdAsync(collectionId);

  if (!collection) {
    figma.ui.postMessage({
      type: "toast",
      data: { message: "Collection not found.", success: false },
    });
    return;
  }

  const variables = await Promise.all(
    collection.variableIds.map((id) => figma.variables.getVariableByIdAsync(id))
  );

  const nestedData: Record<string, any> = {};

  // Hardcoded mode name
  const hardcodedModeName = "FR"; // Change this to "FR" or any other mode name as needed

  // Find the mode ID for the hardcoded mode name
  const hardcodedMode = collection.modes.find((mode) => mode.name === hardcodedModeName);
  if (!hardcodedMode) {
    figma.ui.postMessage({
      type: "toast",
      data: { message: `Mode "${hardcodedModeName}" not found in the collection.`, success: false },
    });
    return;
  }

  const hardcodedModeId = hardcodedMode.modeId;

  variables
    .filter(
      (variable) =>
        variable &&
        variable.resolvedType === "STRING" &&
        !variable.name.startsWith("Placeholder/") &&
        !variable.name.startsWith("Common/")
    )
    .forEach((variable) => {
      const parts = variable!.name.split("/");
      const value = variable!.valuesByMode[hardcodedModeId] || "";

      let currentLevel = nestedData;
      parts.forEach((part, index) => {
        if (index === parts.length - 1) {
          currentLevel[part] = value; // Use the value for the hardcoded mode
        } else {
          if (!currentLevel[part]) {
            currentLevel[part] = {};
          }
          currentLevel = currentLevel[part];
        }
      });
    });

  // Send the JSON data back to the UI
  figma.ui.postMessage({
    type: "export-json",
    data: { jsonContent: JSON.stringify(nestedData, null, 2), collectionName: collection.name },
  });
}

// Handle messages from the UI
figma.ui.onmessage = async (msg) => {
  console.log("Message received in backend:", msg); // Debugging: Log the received message

  if (msg.type === "copy-variable") {
    console.log("Copy variable message received."); // Debugging: Log copy message
    await copyVariable();
  } else if (msg.type === "paste-variable") {
    console.log("Paste variable message received."); // Debugging: Log paste message
    await pasteVariable();
  } else if (msg.type === "fetch-variables") {
    await fetchVariables(msg.collectionId);
  } else if (msg.type === "apply-variable") {
    await applyVariable(msg.variableId);
  } else if (msg.type === "export-collection") {
    await exportCollectionToCSV(msg.collectionId);
  } else if (msg.type === "export-collection-json") {
    await exportCollectionToJSON(msg.collectionId);
  } else if (msg.type === "refresh-ui") {
    handleSelectionChange();
  }
};

// Listen for selection changes
figma.on("selectionchange", handleSelectionChange);

// Initial setup
fetchCollections();
handleSelectionChange();
