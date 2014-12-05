# Export Plugin
module.exports = (BasePlugin) ->
    # Define Plugin
    class Breadcrumb extends BasePlugin
        # Plugin Name
        name: 'breadcrumb'

        extendTemplateData: (opts) ->
            # Prepare
            docpad = @docpad
            config = @config
            documents = docpad.getCollection('documents')
            {templateData} = opts

            templateData.breadcrumb = (document) ->
                document ?= @getDocument()
                breadcrumb = []
                parent = document.get('parent')
                while parent?       
                    if templateData.dd? 
                        referenceDocument = templateData.dd(parent, document)
                    else
                        referenceDocument = documents.findOne(url: parent).toJSON()
                    if referenceDocument?
                        breadcrumb.push referenceDocument
                        parent = referenceDocument.parent
                    else
                        break
                breadcrumb.reverse()
            @  