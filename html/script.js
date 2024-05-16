// Copyright (c) Facebook, Inc. and its affiliates.
// 
// This source code is licensed under the MIT license found in the
// LICENSE file in the root directory of this source tree.

$(function(){function display(bool){if(bool){$("#container").fadeIn(300)}else{$("#container").fadeOut(0)}}
display(!1);window.addEventListener('message',function(event){var item=event.data;if(item.type==="ui"){if(item.status==!0){display(!0)}else{display(!1)}}
if(item.type==="Info"){$("#name").html(item.name+"!");if(item.dienst==!0){$("#dutybutton").html("Go off duty");$("#dutybutton").css("background-color","#ca0d26");$("#dutybutton:hover").css("background-color","#c20d25")}else $("#dutybutton").html("Go on duty");if(item.logs==!0){$("#extrabutton").html("Extras <br>On");$("#extrabutton").css("background-color","#0d4535");$("#extrabutton:hover").css("background-color","#c20d25")}else $("#extrabutton").html("Extras <br>Off")}
if(item.type==='updatePlayerInfo'){updatePlayerList(event.data.playerList)}})
document.addEventListener('keyup',function(event){if(event.code==='Escape'){$.post('https://ndl_adminduty/exit',JSON.stringify({}));return}});$("#dutybutton").click(function(){$.post('https://ndl_adminduty/dutybutton',JSON.stringify({}));return})
$("#extrabutton").click(function(){$.post('https://ndl_adminduty/extrabutton',JSON.stringify({}));return})})
function updatePlayerList(playerList){const playerListElement=document.getElementById('players');playerListElement.innerHTML='';if(playerList&&Array.isArray(playerList)){playerList.forEach(playerInfo=>{const playerDiv=document.createElement('div');playerDiv.id='player'
const playerName=document.createElement('p');playerName.innerText=playerInfo.name;if(playerInfo.self){playerName.style.color='#1d735b'}
playerDiv.appendChild(playerName);playerListElement.appendChild(playerDiv)})}}