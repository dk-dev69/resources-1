var connexions = [];
var kills = [];
var vehicles = [];
var weapons = [];

var searchAwnsers = [];

  
  window.addEventListener('message', function(event){

    var eData = event.data;

    if(eData.show == true) {
      $(".page").addClass("show");
      $(".page").removeClass("hide");

      showPage(0);
    }else if(eData.show == false) {
      $(".page").addClass("hide");
      $(".page").removeClass("show");
    }

    if(eData.updateArray == true) {
      if(eData.uId == 1) {
        upgradeArray(connexions, eData.newthings);
      }else if(eData.uId == 2) {
        upgradeArray(kills, eData.newthings);
      }else if(eData.uId == 3) {
        upgradeArray(vehicles, eData.newthings);
      }else if(eData.uId == 4) {
        upgradeArray(weapons, eData.newthings);
      }
    }

    if(eData.updateHomeStats == true) {
      updateHomeStats(eData.homeId, eData.statValue);
    }

  });

    var pageNames = ["home", "logArrays", "search"];

  function showPage(id) {
    var getPage = id;
    if(getPage > 2) {
      getPage = 1;
    }
    for (var i = 0; i < pageNames.length; i++) {
     

      if(i == getPage) {
        var curPage = $("#"+pageNames[i]);
        curPage.removeClass("hide");
        curPage.addClass("show");
      }else{
        var curPage = $("#"+pageNames[i]);
        curPage.removeClass("show");
        curPage.addClass("hide");
      }
    }

    if(id==3) {
      launchLog(connexions);
    } else if(id == 4) {
      launchLog(kills);
    } else if(id == 5) {
      launchLog(vehicles);
    } else if(id == 6){
      launchLog(weapons);
    }
  }


  function upgradeArray(array, toAddArray) {
    for (var i = 0; i < toAddArray.length; i++) {
      array.push(toAddArray[i]);
    }
  }


  function init() {
    for (var i = 0; i < pageNames.length; i++) {
      var curPage = $("#"+pageNames[i]);
      curPage.addClass("hide");
    }
  }




  function launchLog(array) {
    var informations = "";
    for (var i = array.length-1; i >= 0; i--) {
      informations += "<hr><li class=\"listElem\" id=\"listElem_"+i+"\">"+array[i]+"</li>";
    }

    $("#container").replaceWith('<div id="container"><ul>'+informations+'<hr></ul></div>');
  }


  function updateHomeStats(id, value) {

    if(id==1) {
      $("#kills").replaceWith('<div class="statsBlock" id="kills"><p id="sTitle">'+value+'</p><p id="sDesc">Смертей</p></div>');
    }else if(id==2) {
      $("#PoliceVehicles").replaceWith('<div class="statsBlock" id="PoliceVehicles"><p id="sTitle">'+value+'</p><p id="sDesc">использовал полицейского автомобиля</p></div>');
    }else if(id==3) {
      $("#blVehicules").replaceWith('<div class="statsBlock" id="blVehicules"><p id="sTitle">'+value+'</p><p id="sDesc">использовал автомобили из черного списка</p></div>');
    }else if(id==4) {
      $("#blWeapons").replaceWith('<div class="statsBlock" id="blWeapons"><p id="sTitle">'+value+'</p><p id="sDesc">использовал оружие из черного списка</p></div>');
    }

  }


  function copyToClipboard(element) {
    var $temp = $("<input>");
    $("body").append($temp);
    $temp.val($(element).text()).select();
    document.execCommand("copy");
    $temp.remove();
  }


  function startSearch() {
    var text = document.getElementsByClassName("searchTerm")[0].value;

    showPage(2);

    searchTag(connexions, text, "sContainerConnexions");
    searchTag(kills, text, "sContainerKills");
    searchTag(vehicles, text, "sContainerVehicules");
    searchTag(weapons, text, "sContainerblWeapons");



  }


  function searchTag(array,tag, divName) {
    tag = tag.toLowerCase();
    var result = [];
    for (var i = 0; i < array.length; i++) {
      var toTest = array[i].toLowerCase();
      if(toTest.includes(tag)) {
        result.push(array[i]);
      }
    }

    var informations = "";
    for (var i = result.length-1; i >= 0; i--) {
      informations += "<hr><li class=\"listElem\" id=\"listElem_"+divName+"_"+i+"\">"+result[i]+"</li>";
    }

    $("#"+divName).replaceWith('<div id="'+divName+'"><ul>'+informations+'<hr></ul></div>');
  }


  $(document).ready(function() {
    init();
    $(".page").addClass("hide");
    showPage(0);
    $('*').on('click', function(event) {
      var id = event.target.id;
      if(id.includes("listElem_")) {
        copyToClipboard("#"+id);
     }
         
    });
  });


  function post(name, data) {
    $.post('http://logs/'+name, JSON.stringify(data));
  }

  function closeMenu() {
    post("close", {});
  }


