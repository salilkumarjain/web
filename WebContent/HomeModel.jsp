<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="css/main.css">
<script type="text/javascript" src="js/big.min.js"></script>
<script type="text/javascript" src="js/gl-matrix-min.js"></script>
<script type="text/javascript" src="js/jszip.min.js"></script>
<script type="text/javascript" src="js/core.min.js"></script>
<script type="text/javascript" src="js/geom.min.js"></script>
<script type="text/javascript" src="js/batik-svgpathparser.min.js"></script>
<script type="text/javascript" src="js/jsXmlSaxParser.min.js"></script>
<script type="text/javascript" src="js/triangulator.min.js"></script>
<script type="text/javascript" src="js/viewmodel.min.js"></script>
<script type="text/javascript" src="js/viewhome.min.js"></script>
<style type="text/css">
/* The class of components handled by the viewer */
.viewerComponent  {

color: #d56565;

}
</style>
<title>Salil - Home 3D HTML5 Viewer</title>
</head>
 <body>

        <div class="main-container-1">
        	<!-- Copy the following canvas and components in your page, changing their size / texts and other values if needed  -->
		  <canvas id="viewerCanvas" class="viewerComponent" width="1350" height="560"
		          style="background-color: #CCCCCC; border: 1px solid gray; outline:none" tabIndex="1"></canvas>
		  <div id="viewerProgressDiv" style="width: 450px; position: relative; top: -350px; left: 500px; background-color: rgba(31, 37, 61, 0.7); padding: 20px; border-radius: 25px">
		    <progress id="viewerProgress"  class="viewerComponent" value="0" max="200" style="width: 410px"></progress>
		    <label id="viewerProgressLabel" class="viewerComponent" style="margin-top: 2px; display: block; margin-left: 10px"></label>
		  </div>
		  <div style="margin-top: -60px">
		  	<label class="viewerComponent" for="dd" style="visibility: visible;">Select Level : </label>
		  	<select id="levelsAndCameras" class="viewerComponent" style="visibility: hidden;"></select>
		    <input  id="aerialView"   class="viewerComponent" name="cameraType" type="radio" style="visibility: hidden;"/>
		      <label class="viewerComponent" for="aerialView" style="visibility: hidden;">Aerial view</label>
		    <input  id="virtualVisit" class="viewerComponent" name="cameraType" type="radio" style="visibility: hidden;"/>
		      <label class="viewerComponent" for="virtualVisit" style="visibility: hidden;">Virtual visit</label>
		  </div>
        </div>

</body>
<script type="text/javascript">
  var homeUrl = "Home3D.zip";
  var onerror = function(err) {
      if (err == "No WebGL") {
        alert("Sorry, your browser doesn't support WebGL.");
      } else {
        console.log(err.stack);
        alert("Error: " + (err.message  ? err.constructor.name + " " +  err.message  : err));
      }
    };
  var onprogression = function(part, info, percentage) {
      var progress = document.getElementById("viewerProgress"); 
      if (part === HomeRecorder.READING_HOME) {
        // Home loading is finished 
        progress.value = percentage * 100;
        info = info.substring(info.lastIndexOf('/') + 1);
      } else if (part === Node3D.READING_MODEL) {
        // Models loading is finished 
        progress.value = 100 + percentage * 100;
        if (percentage === 1) {
          document.getElementById("viewerProgressDiv").style.visibility = "hidden";
        }
      }
    
      document.getElementById("viewerProgressLabel").innerHTML = 
          (percentage ? Math.floor(percentage * 100) + "% " : "") + part + " " + info;
    };
   
  // Display home in canvas 3D
  // Mouse and keyboard navigation explained at 
  // http://sweethome3d.cvs.sf.net/viewvc/sweethome3d/SweetHome3D/src/com/eteks/sweethome3d/viewcontroller/resources/help/en/editing3DView.html
  // You may also switch between aerial view and virtual visit with the space bar
  // For browser compatibility, see http://caniuse.com/webgl
  viewHome("viewerCanvas",    // Id of the canvas
           homeUrl,           // URL or relative URL of the home to display 
           onerror,           // Callback called in case of error
           onprogression,     // Callback called while loading 
          {roundsPerMinute: 2,                    // Rotation speed of the animation launched once home is loaded in rounds per minute, no animation if missing or equal to 0 
           navigationPanel: "default",               // Displayed navigation arrows, "none" or "default" for default one or an HTML string containing elements with data-simulated-key 
                                                  // attribute set "UP", "DOWN", "LEFT", "RIGHT"... to replace the default navigation panel, "none" if missing 
           aerialViewButtonId: "aerialView",      // Id of the aerial view radio button, radio buttons hidden if missing  
           virtualVisitButtonId: "virtualVisit",  // Id of the aerial view radio button, radio buttons hidden if missing  
           levelsAndCamerasListId: "levelsAndCameras",          // Id of the levels and cameras select component, hidden if missing
        /* level: "Roof", */                                    // Uncomment to select the displayed level, default level if missing */
        /* selectableLevels: ["Ground floor", "Roof"], */       // Uncomment to choose the list of displayed levels, no select component if empty array */
        /* camera: "Exterior view", */                          // Uncomment to select a camera, default camera if missing */
        /* selectableCameras: ["Exterior view", "Kitchen"], */  // Uncomment to choose the list of displayed cameras, no camera if missing */
           activateCameraSwitchKey: true                        // Switch between top view / virtual visit with space bar if not false or missing */
          });  
</script>
</html>