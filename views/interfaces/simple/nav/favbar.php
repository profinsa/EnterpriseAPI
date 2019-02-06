<div class="favbar">
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
</div>
<script>
    var currentShortcut = null;

    function createIconbarRow(id) {
        var shortcutsRaw = localStorage.getItem('shortcuts');
        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

        var hh = "index#/grid/" + id + "/grid/Main/all";
        $('#MyShortcuts').append(
            '<li id="' + id + '"style="height:60px; width: 100%"><a style="width: 100%; height: 100%; padding-top: 25px;padding-right: 5px; padding-left: 5px;" href="' + hh + '" class="nav-link">' + shortcuts[id].label + '</a></li>'
        );
        $('#MyShortcuts2').append(
            '<li id="' + id + '2"style="height:60px; width: 100%"><a style="width: 100%; height: 100%; padding-top: 25px;padding-right: 5px; padding-left: 5px;" href="' + hh + '" class="nav-link">' + shortcuts[id].label + '</a></li>'
        );
    }

    function updateIconbarRows() {
        function compare(a,b) {
            if (a.order < b.order)
                return -1;
            if (a.order > b.order)
                return 1;
            return 0;
        }
        var shortcutsRaw = localStorage.getItem('shortcuts');
        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};
        var keys = Object.keys(shortcuts).map(function (key) {
            return shortcuts[key];
        }).sort(compare);
        // var keys = Object.keys(shortcuts);
        var select = document.getElementById('MyShortcuts');
        var action = null;
        while (select.firstChild) {
            if (select.firstChild.id === "CustomizeShortcuts") {
                action = select.firstChild;
            }
            select.removeChild(select.firstChild);
        }

        // var select2 = document.getElementById('MyShortcuts2');
        // var action2 = null;
        // while (select2.firstChild) {
        //     if (select2.firstChild.id === "CustomizeShortcuts2") {
        //         action2 = select2.firstChild;
        //     }
        //     select2.removeChild(select2.firstChild);
        // }


        for (var i = 0; i < keys.length; i++) {
            createIconbarRow(keys[i].id);
        }

        select.appendChild(action);
        // select2.appendChild(action2);
    }

    $(document).ready(function () {
        if (localStorage.getItem('version') !== '0.02') {
            localStorage.setItem('shortcuts', JSON.stringify({}));
            localStorage.setItem('version', '0.02');
        } else {
            updateIconbarRows();
        }
    });

    function onDeleteShortcut() {
        if (currentShortcut) {
            var shortcutsRaw = localStorage.getItem('shortcuts');
            var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

            var answer = confirm("Do you really want to delete this Shortcut?");
            if (answer) {
                var keys = Object.keys(shortcuts);

                buf = {};
                
                for (var i = 0; i < keys.length; i++) {
                    if (keys[i] !== currentShortcut) {
                        buf[keys[i]] = shortcuts[keys[i]];
                    }
                }

                localStorage.setItem('shortcuts', JSON.stringify(buf));
                var select = document.getElementById('icon-bar-content');
                select.removeChild(document.getElementById(currentShortcut));
                updateIconbarRows();
            }
        }
    }

    function onSelectShortcut(event) {
        currentShortcut = $("#icon-bar-content").val();
    }

    function onSelectNewShortcut(event) {
        currentShortcut = $("#icon-bar-content-add").val();
        $("#ShortcutLabel").val(shortcutsMenu[currentShortcut].full);
        $("#ShortcutDescription").val(shortcutsMenu[currentShortcut].full);
    }

    function addShortcut() {
        if (currentShortcut) {
            var shortcutsRaw = localStorage.getItem('shortcuts');
            var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

            var ord = 0;
            var keys = Object.keys(shortcuts);

            for (var i = 0; i < keys.length; i++) {
                if (shortcuts[keys[i]].order > ord) {
                    ord = shortcuts[keys[i]].order;
                }
            }

            console.log(ord, shortcuts);

            shortcuts[currentShortcut] = {
                full: shortcutsMenu[currentShortcut].full,
                href: shortcutsMenu[currentShortcut].href,
                short: shortcutsMenu[currentShortcut].short,
                id: shortcutsMenu[currentShortcut].id,
                label: $("#ShortcutLabel").val(),
                description: $("#ShortcutDescription").val(),
                order: ord + 1
            };

            localStorage.setItem('shortcuts', JSON.stringify(shortcuts));
            updateIconbarRows();
        }
    }
    
    function custormizeShortcutsUp() {
        var shortcutsRaw = localStorage.getItem('shortcuts');
        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

        var buf = shortcuts[currentShortcut].order;
        var ord = 0;
        var prev;

        var keys = Object.keys(shortcuts);

        for (var i = 0; i < keys.length; i++) {
            if ((shortcuts[keys[i]].order > ord) && (shortcuts[keys[i]].order < buf)) {
                ord = shortcuts[keys[i]].order;
                prev = shortcuts[keys[i]].id;
            }
        }

        // console.log(currentShortcut, prev, ord, buf);

        if (prev) {
            shortcuts[currentShortcut].order = ord;
            shortcuts[prev].order = buf;
        }

        localStorage.setItem('shortcuts', JSON.stringify(shortcuts));
        updateIconbarRows();
        rebuild();
    }

    function custormizeShortcutsDown() {
        var shortcutsRaw = localStorage.getItem('shortcuts');
        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

        var buf = shortcuts[currentShortcut].order;
        var ord = 1000000000000;
        var next;

        var keys = Object.keys(shortcuts);

        for (var i = 0; i < keys.length; i++) {
            if ((shortcuts[keys[i]].order < ord) && (shortcuts[keys[i]].order > buf)) {
                ord = shortcuts[keys[i]].order;
                next = shortcuts[keys[i]].id;
            }
        }

        if (next) {
            shortcuts[currentShortcut].order = ord;
            shortcuts[next].order = buf;
        }

        localStorage.setItem('shortcuts', JSON.stringify(shortcuts));
        updateIconbarRows();
        rebuild();
    }

    function custormizeShortcutsOpen() {
        function compare(a,b) {
            if (a.order < b.order)
                return -1;
            if (a.order > b.order)
                return 1;
            return 0;
        }

        $('#customize-icon-bar').modal('show');
        currentShortcut = null; 
        var shortcutsRaw = localStorage.getItem('shortcuts');
        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};
        var keys = Object.keys(shortcuts).map(function (key) {
            return shortcuts[key];
        }).sort(compare);
        // var keys = Object.keys(shortcuts);
        var select = document.getElementById('icon-bar-content');
        
        while (select.firstChild) {
            select.removeChild(select.firstChild);
        }

        for (var i = 0; i < keys.length; i++) {
            var option = document.createElement('option');
            option.value = keys[i].id;
            option.id = keys[i].id;
            option.innerHTML = shortcuts[keys[i].id].label;
            select.appendChild(option);
        }
    }

    function rebuild() {
        function compare(a,b) {
            if (a.order < b.order)
                return -1;
            if (a.order > b.order)
                return 1;
            return 0;
        }

        // $('#customize-icon-bar').modal('show');
        // currentShortcut = null; 
        var shortcutsRaw = localStorage.getItem('shortcuts');
        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};
        var keys = Object.keys(shortcuts).map(function (key) {
            return shortcuts[key];
        }).sort(compare);
        // var keys = Object.keys(shortcuts);
        var select = document.getElementById('icon-bar-content');
        
        while (select.firstChild) {
            select.removeChild(select.firstChild);
        }

        for (var i = 0; i < keys.length; i++) {
            var option = document.createElement('option');
            option.value = keys[i].id;
            option.id = keys[i].id;
            option.innerHTML = shortcuts[keys[i].id].label;
            if (keys[i].id === currentShortcut) {
                option.selected = "selected";
            }
            select.appendChild(option);
        }
    }


    function saveShortcut() {
        var shortcutsRaw = localStorage.getItem('shortcuts');
        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

        shortcuts[currentShortcut].label = $("#ShortcutLabelEdit").val();
        shortcuts[currentShortcut].description = $("#ShortcutDescriptionEdit").val();

        localStorage.setItem('shortcuts', JSON.stringify(shortcuts));
        updateIconbarRows();
    }

    function custormizeShortcutsEditOpen() {
        var shortcutsRaw = localStorage.getItem('shortcuts');
        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

        $("#ShortcutLabelEdit").val(shortcuts[currentShortcut].label);
        $("#ShortcutDescriptionEdit").val(shortcuts[currentShortcut].description);
        $('#customize-icon-bar').modal('hide');
        $('#customize-icon-bar-edit').modal('show');
    }

    function custormizeShortcutsAddOpen() {
        var shortcutsRaw = localStorage.getItem('shortcuts');
        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};
        shortcutsMenu = {};

        var subkeys = Object.keys(window.menuCategories);

        for (var i = 0; i < subkeys.length; i++) {
            if (window.menuCategories[subkeys[i]].data && window.menuCategories[subkeys[i]].data.length) {
                for (var j = 0; j < window.menuCategories[subkeys[i]].data.length; j++) {
                    if (window.menuCategories[subkeys[i]].data[j].data && window.menuCategories[subkeys[i]].data[j].data.length) {
                        for (var k = 0; k < window.menuCategories[subkeys[i]].data[j].data.length; k++) {
                            shortcutsMenu[window.menuCategories[subkeys[i]].data[j].data[k].id] = {
                                full: window.menuCategories[subkeys[i]].data[j].data[k].full,
                                href: window.menuCategories[subkeys[i]].data[j].data[k].href,
                                id: window.menuCategories[subkeys[i]].data[j].data[k].id,
                                short: window.menuCategories[subkeys[i]].data[j].data[k].short
                            }
                        }
                    } else {
                        shortcutsMenu[window.menuCategories[subkeys[i]].data[j].id] = {
                            full: window.menuCategories[subkeys[i]].data[j].full,
                            href: window.menuCategories[subkeys[i]].data[j].href,
                            id: window.menuCategories[subkeys[i]].data[j].id,
                            short: window.menuCategories[subkeys[i]].data[j].short
                        }
                    }
                }
            }
        }

        var keys = Object.keys(shortcutsMenu);

        var select = document.getElementById('icon-bar-content-add');

        for (var i = 0; i < keys.length; i++) {
            if (!shortcuts[keys[i]]) {
                var option = document.createElement('option');
                option.value = keys[i];
                option.innerHTML = shortcutsMenu[keys[i]].full;
                select.appendChild(option);
            }
        }

        currentShortcut = null;
        $('#customize-icon-bar').modal('hide');
        $('#customize-icon-bar-add').modal('show');
    }

    $('#customize-icon-bar-add').on('hidden.bs.modal', function () {
        setTimeout(function() {
            custormizeShortcutsOpen();
        }, 0);
    })
    $('#customize-icon-bar-edit').on('hidden.bs.modal', function () {
        setTimeout(function() {
            custormizeShortcutsOpen();
        }, 0);
    })
</script>
