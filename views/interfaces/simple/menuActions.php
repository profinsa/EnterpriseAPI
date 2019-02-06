<div id="customize-icon-bar-edit" class="modal fade" tabindex="-1" role="dialog" style="z-index: 1700">
<div class="modal-dialog" role="document" style="display:table;">
    <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Edit Icon Bar Item</h4>
    </div>
    <div class="modal-body">
        <div style="margin-top:10px;"></div>
        <form class="form-material form-horizontal m-t-30">
        <div class="row">
        <div class="col-md-6 col-xs-6">
            <div class="form-group col-md-12 col-xs-12">
                <label for="ShortcutLabel" class="col-md-6 col-xs-6">label</label>
                <div class="col-md-6 col-xs-6">
                <input id="ShortcutLabelEdit" style="display:inline" type="text" name="ShortcutLabel" class="form-control"/>
                </div>
            </div>
            <div class="form-group col-md-12 col-xs-12">
                <label for="ShortcutDescription" class="col-md-6 col-xs-6">Description</label>
                <div class="col-md-6 col-xs-6">
                <input id="ShortcutDescriptionEdit" style="display:inline" type="text" name="ShortcutDescription" class="form-control"/>
                </div>
            </div>
        </div>
        </div>
        </form>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="saveShortcut()">
        <?php echo $translation->translateLabel("Ok"); ?>
        </button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">
        <?php echo $translation->translateLabel("Cancel"); ?>
        </button>
    </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="customize-icon-bar-add" class="modal fade" tabindex="-1" role="dialog" style="z-index: 1700">
<div class="modal-dialog" role="document" style="display:table;">
    <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Add Custom Bar Item</h4>
    </div>
    <div class="modal-body">
        <div style="margin-top:10px;"></div>
        <form class="form-material form-horizontal m-t-30">
        <div class="row">
        <div class="col-md-6 col-xs-6">
        <div class="form-group">
            <select size="10" class="form-control" name="icon-bar-content-add" id="icon-bar-content-add" onchange="onSelectNewShortcut(event)">
            </select>
        </div>
        </div>
        <div class="col-md-6 col-xs-6">
            <div class="form-group col-md-12 col-xs-12">
                <label for="ShortcutLabel" class="col-md-6 col-xs-6">label</label>
                <div class="col-md-6 col-xs-6">
                <input id="ShortcutLabel" style="display:inline" type="text" name="ShortcutLabel" class="form-control"/>
                </div>
            </div>
            <div class="form-group col-md-12 col-xs-12">
                <label for="ShortcutDescription" class="col-md-6 col-xs-6">Description</label>
                <div class="col-md-6 col-xs-6">
                <input id="ShortcutDescription" style="display:inline" type="text" name="ShortcutDescription" class="form-control"/>
                </div>
            </div>
        </div>
        </div>
        </form>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal" onclick="addShortcut()">
        <?php echo $translation->translateLabel("Ok"); ?>
        </button>
        <button type="button" class="btn btn-primary" data-dismiss="modal">
        <?php echo $translation->translateLabel("Cancel"); ?>
        </button>
    </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<div id="customize-icon-bar" class="modal fade" tabindex="-1" role="dialog">
<div class="modal-dialog" role="document" style="display:table;">
    <div class="modal-content">
    <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title">Customize My ShortCuts</h4>
    </div>
    <div class="modal-body">
        <div style="margin-top:10px;"></div>
        <form class="form-material form-horizontal m-t-30">
        <h3 class="box-title m-b-0">My ShortCuts Content</h3>
        <div class="row">
        <div class="col-md-6 col-xs-6">
        <div class="form-group">
            <select size="10" class="form-control" name="icon-bar-content" id="icon-bar-content" onchange="onSelectShortcut(event)">
            </select>
        </div>
        </div>
        <div class="col-md-6 col-xs-6" style="text-align: center">
            <div class="row">
            <a class="btn btn-info" onclick="custormizeShortcutsAddOpen()">
                <?php echo $translation->translateLabel("Add"); ?>
            </a>
            </div>
            <br/>
            <div class="row">
            <a class="btn btn-info" onclick="custormizeShortcutsEditOpen()">
                <?php echo $translation->translateLabel("Edit"); ?>
            </a>
            </div>
            <br/>
            <div class="row">
            <a class="btn btn-info" onclick="onDeleteShortcut()">
                <?php echo $translation->translateLabel("Delete"); ?>
            </a>
            </div>
            <br/>
            <div class="row">
            <a class="btn btn-info" onclick="custormizeShortcutsUp()">
                <?php echo $translation->translateLabel("Up"); ?>
            </a>
            </div>
            <br/>
            <div class="row">
            <a class="btn btn-info" onclick="custormizeShortcutsDown()">
                <?php echo $translation->translateLabel("Down"); ?>
            </a>
            </div>
        </div>
        </div>
        </form>
    </div>
    <div class="modal-footer">
        <button type="button" class="btn btn-primary" data-dismiss="modal">
        <?php echo $translation->translateLabel("Ok"); ?>
        </button>
    </div>
    </div><!-- /.modal-content -->
</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
