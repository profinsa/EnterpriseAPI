<div class="row bg-title" style="margin-bottom: 15px; margin-top:20px;">
    <div class="col-md-8">
	<h4 class="page-title" style="display: inline-block; float: left"><?php echo $data->dashboardTitle . '  -  ' . $user["EmployeeUserName"] . ' '. $user["EmployeeName"]; ?></h4>
    <div id="MyFavorit" style="margin-top: 7px">
    </div>
	<?php if(isset($ascope) && key_exists("mode", $ascope) && isset($data) && method_exists($data, "lockedBy") &&  $ascope["mode"] == "view"): ?>
	    <?php
		$lockedBy = $data->lockedBy($ascope["item"]);
	    ?>
	    <?php if($lockedBy): ?>
		<h5 class="page-title" style="display: inline-block; float: right; color: red; margin-top:25px">
		    Locked By <?php echo $lockedBy->LockedBy; ?> at <?php echo $lockedBy->LockTS; ?>
		</h5>
	    <?php endif; ?>
	<?php endif; ?>
    </div>
    <div class="col-mm-4 pull-right" style="text-align: right">
	<ol class="breadcrumb">
	    <li><a href="index#/dashboard">Dashboard</a></li>
	    <li class="active"><?php echo $data->breadCrumbTitle ?></li>
	</ol>
    </div>
</div>

<script>
    function checkForFavorits() {
        var path = "<?php echo $ascope["path"]; ?>";
        var mode = "<?php echo $ascope["mode"]; ?>";
        var shortcutsRaw = localStorage.getItem('shortcuts');

        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

        if (shortcuts.hasOwnProperty(path)) {
            //todo highlight heart
            $("#MyFavorit").empty();
            $("#MyFavorit").append("<span title=\"remove from shortcuts\" style=\"color: red !important\" onclick=\"addToFavorits()\" class=\"favorits glyphicon glyphicon-heart\" aria-hidden=\"true\"></span>");
        } else if (mode === "grid") {
            $("#MyFavorit").empty();
            $("#MyFavorit").append("<span title=\"remove from shortcuts\" style=\"color: #919293 !important\" onclick=\"addToFavorits()\" class=\"favorits glyphicon glyphicon-heart-empty\" aria-hidden=\"true\"></span>");
        }
    }

    checkForFavorits();

    function addToFavorits() {
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

        var path = "<?php echo $ascope["path"]; ?>";
        var shortcutsRaw = localStorage.getItem('shortcuts');
        var shortcuts = shortcutsRaw ? JSON.parse(shortcutsRaw) : {};

        if (shortcuts.hasOwnProperty(path)) {
            $("#MyFavorit").empty();
            $("#MyFavorit").append("<span title=\"Add to favorits\" style=\"color: #919293 !important\" onclick=\"addToFavorits()\" class=\"favorits glyphicon glyphicon-heart-empty\" aria-hidden=\"true\"></span>");

            buf = {};
            
            for (var i = 0; i < keys.length; i++) {
                if (keys[i] !== path) {
                    buf[keys[i]] = shortcuts[keys[i]];
                }
            }

            localStorage.setItem('shortcuts', JSON.stringify(buf));
            updateIconbarRows();
        } else {
            $("#MyFavorit").empty();
            $("#MyFavorit").append("<span title=\"Remove from favorits\" style=\"color: red !important\" onclick=\"addToFavorits()\" class=\"favorits glyphicon glyphicon-heart\" aria-hidden=\"true\"></span>");

            var ord = 0;
            var keys = Object.keys(shortcuts);

            for (var i = 0; i < keys.length; i++) {
                if (shortcuts[keys[i]].order > ord) {
                    ord = shortcuts[keys[i]].order;
                }
            }

            shortcuts[path] = {
                full: shortcutsMenu[path].full,
                href: shortcutsMenu[path].href,
                short: shortcutsMenu[path].short,
                id: shortcutsMenu[path].id,
                label: shortcutsMenu[path].full,
                description: shortcutsMenu[path].full,
                order: ord + 1
            };

            localStorage.setItem('shortcuts', JSON.stringify(shortcuts));
            updateIconbarRows();
        }
    }

</script>