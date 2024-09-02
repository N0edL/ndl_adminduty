$(function () {
    function display(bool) {
        if (bool) {
            $("#container").fadeIn(300);
        } else {
            $("#container").fadeOut(0);
        }
    }
    display(false);
    window.addEventListener('message', function (event) {
        var item = event.data;
        if (item.type === "off") {
            if (item.status == true) {
                display(true);
            } else {
                display(false);
            }
        }

        if (item.type === "Info") {
            $("#name").html(item.name + "!");
            if (item.dienst == true) {
                $("#dutybutton").html("Go off duty");
                $("#dutybutton").css("background-color", "#ca0d26");
                $("#dutybutton:hover").css("background-color", "#c20d25");
            } else
                $("#dutybutton").html("Go on duty");
            
            if (item.logs == true) {
                $("#extrabutton").html("Extras <br>On");
                $("#extrabutton").css("background-color", "#0d4535");
                $("#extrabutton:hover").css("background-color", "#c20d25");
            }
            else
                $("#extrabutton").html("Extras <br>Off");

            
        }

        if (item.type === 'updatePlayerInfo') {
            updateadminList(event.data.adminList);
        }
    })
    document.onkeyup = function (data) {
        if (data.which == 27) {
            $.post('https://ndl_adminui/exit', JSON.stringify({}));
            return;
        }
    };

    $("#dutybutton").click(function () {
        $.post('https://ndl_adminui/dutybutton', JSON.stringify({}));
        return
    })

    $("#extrabutton").click(function () {
        $.post('https://ndl_adminui/extrabutton', JSON.stringify({}));
        return
    })
})
function updateadminList(adminList) {
    const adminListElement = document.getElementById('players');
    adminListElement.innerHTML = '';

    if (adminList && Array.isArray(adminList)) {
        adminList.forEach(playerInfo => {
            // console.log(playerInfo);
            const playerDiv = document.createElement('div');
            playerDiv.id = 'player'
            const playerName = document.createElement('p');

            playerName.innerText = playerInfo.name;

            if (playerInfo.self) {
                playerName.style.color = '#1d735b';
            }
            playerDiv.appendChild(playerName);
            adminListElement.appendChild(playerDiv);
        });
    }
}