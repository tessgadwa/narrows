const {EditorState} = require("prosemirror-state");
const {MenuBarEditorView} = require("prosemirror-menu");
const {Node, DOMSerializer} = require("prosemirror-model");
const {editorSetup} = require("./setup");

function _importText(text, schema) {
    if (!text) {
        return undefined;
    }
    return Node.fromJSON(schema, text);
}

function _textToState(text, schema) {
    return EditorState.create({
        doc: _importText(text, schema),
        schema: schema,
        plugins: editorSetup({schema: schema})
    });
}

function create(initialContent, schema, place, onChangeHandler) {
    const view = new MenuBarEditorView(place, {
        state: _textToState(initialContent, schema),
        images: [],
        dispatchTransaction: tr => {
            view.updateState(view.editor.state.apply(tr));
            onChangeHandler(view);
        }
    });

    return view;
}

function updateText(editor, newText, schema) {
    editor.updateState(_textToState(newText, schema));
}

function exportText(editor) {
    return editor.state.doc.toJSON();
}

function exportTextToDOM(text, schema) {
    const importedText = _importText(text, schema);
    const serializer = DOMSerializer.fromSchema(schema);
    return serializer.serializeFragment(importedText.content);
}

function updateParticipants(editorView, participants) {
    editorView.props.participants = participants;
}

module.exports.create = create;
module.exports.updateText = updateText;
module.exports.exportText = exportText;
module.exports.exportTextToDOM = exportTextToDOM;
module.exports.updateParticipants = updateParticipants;
