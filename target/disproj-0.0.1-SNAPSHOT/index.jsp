
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<title>distance between user origin and destination</title>
<link href="bootstrap.min.css" />
<link rel="preconnect" href="https://fonts.gstatic.com">
<script src="https://kit.fontawesome.com/ab2155e76b.js"
	crossorigin="anonymous">
	
</script>
<link rel="preconnect" href="https://fonts.gstatic.com">
<link
	href="https://fonts.googleapis.com/css2?family=Poppins&display=swap">

<!-- using css -->
<style>
/*add font family,*/
html, body {
	height: 100%;
	margin: 0;
	padding: 0;
}

.fa-map-marker-alt, .fa-dot-circle {
	color: #5bc0de;
}

.card {
	background: #000000d0;
	color: white;
	padding: 2em;
	border-radius: 30px;
	width: 100%;
	max-width: 420px;
	margin: 1em;
}

.jumbotron {
	background-color: transparent;
	text-align: center;
}

.jumbotron h1 {
	letter-spacing: 2.5px;
	font-size: 3.5em;
}

.jumbotron h1, .jumbotron p {
	text-align: center;
}

#floating-panel {
	position: absolute;
	top: 10px;
	left: 25%;
	z-index: 5;
	background-color: #fff;
	padding: 5px;
	border: 1px solid #999;
	text-align: center;
	font-family: 'Roboto', 'sans-serif';
	line-height: 30px;
	padding-left: 10px;
	opacity: 0.8;
}

#googleMap {
	width: 100%;
	height: 800px;
	margin: 18px auto;
}
/*output box*/
#
output {
	text-align: center;
	font-size: 2em;
	margin: 20px auto;
}

#mode {
	color: blue;
}

.card {
	background: #000000d0;
	color: white;
	padding: 2em;
	border-radius: 30px;
	width: 100%;
	max-width: 420px;
	margin: 1em;
}

.search {
	display: flex;
	align-items: center;
	justify-content: center;
}

button {
	margin: 0.5em;
	border-radius: 50%;
	border: none;
	height: 44px;
	width: 44px;
	outline: none;
	background: #7c7c7c2b;
	color: white;
	cursor: pointer;
	transition: 0.2s ease-in-out;
}

input.search-bar {
	border: none;
	outline: none;
	padding: 0.4em 1em;
	border-radius: 24px;
	background: #7c7c7c2b;
	color: white;
	font-family: inherit;
	font-size: 105%;
	width: calc(100% - 100px);
}

button:hover {
	background: #7c7c7c6b;
}

h1.temp {
	margin: 0;
	margin-bottom: 0.4em;
}

.flex {
	display: flex;
	align-items: center;
}

.description {
	text-transform: capitalize;
	margin-left: 8px;
}

.weather.loading {
	visibility: hidden;
	max-height: 20px;
	position: relative;
}

.weather.loading:after {
	visibility: visible;
	content: "Loading...";
	color: white;
	position: absolute;
	top: 0;
	left: 20px;
}
</style>
</head>
<body>


	<div class="jumbotron">
		<div class="container-fluid">

			<div id="floating-panel">
				<p>PROVIDE LOCATION AND DESTINATION</p>

				<form class="form-horizontal">
					<div class="form-group">

						<div class="col-xs-4">
							<input type="text" id="from" placeholder="Origin"
								class="form-control">
						</div>
					</div>
					<div class="form-group">

						<div class="col-xs-4">
							<input type="text" id="to" placeholder="Destination"
								class="form-control">


						</div>
					</div>

				</form>



				<div class="col-xs-offset-2 col-xs-10">
					<button class="btn btn-info btn-lg " onclick="routecalculation();">
						<i class="fas fa-map-signs"></i>
					</button>
				</div>
			</div>
		</div>
	</div>
	
	<div class="container-fluid">
		<div id="googleMap"></div>
		<div id="output"></div>
	</div>
	<div class="card">
		<div class="search">
			<input type="text" class="search-bar" placeholder="Search">
			<button>
				<svg stroke="currentColor" fill="currentColor" stroke-width="0"
					viewBox="0 0 1024 1024" height="1.5em" width="1.5em"
					xmlns="http://www.w3.org/2000/svg">
        
        </svg>
			</button>
		</div>
		<div class="weather loading">
			<h2 class="city">Weather in Denver</h2>
			<h1 class="temp">51°C</h1>
			<div class="flex">
				<img src="https://openweathermap.org/img/wn/04n.png" alt=""
					class="icon" />
				<div class="description">Cloudy</div>
			</div>
			<div class="humidity">Humidity: 60%</div>
			<div class="wind">Wind speed: 6.2 km/h</div>
		</div>
	</div>


	<!-- javascript for google API access -->
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBAh14jX_szt0Dz-eG_aPWZ_T29kYhM6g8&libraries=places"></script>
	<!--download and host jQuery through CDN -->
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>

	<!-- to include jquery inside our program -->
	<script src="jquery-3.1.1.min.js"></script>


	<script>
		var myLatLng = {
			lat : 27.1766701,
			lng : 78.0080745
		};
		var mapOptions = {
			center : myLatLng,
			zoom : 8,
			mapTypeId : google.maps.MapTypeId.ROADMAP

		};

		//create map
		var map = new google.maps.Map(document.getElementById('googleMap'),
				mapOptions);

		//DirectionsService object to use the route method and get a result for our request
		var directionsService = new google.maps.DirectionsService();

		//create a DirectionsRenderer object which we will use to display the route
		var directionsDisplay = new google.maps.DirectionsRenderer();

		//bind the DirectionsRenderer to the map
		directionsDisplay.setMap(map);

		//define routecalculation() function
		function routecalculation() {
			//create request
			var request = {
				origin : document.getElementById("from").value,
				destination : document.getElementById("to").value,
				travelMode : google.maps.TravelMode.DRIVING, //WALKING, BYCYCLING, TRANSIT
				unitSystem : google.maps.UnitSystem.IMPERIAL
			}

			//pass the request to the route method
			directionsService
					.route(
							request,
							function(result, status) {
								if (status == google.maps.DirectionsStatus.OK) {

									//Get distance and time
									const output = document
											.querySelector('#output');
									output.innerHTML = "<div class='alert-info'>From: "
											+ document.getElementById("from").value
											+ ".<br />To: "
											+ document.getElementById("to").value
											+ ".<br /> Driving distance <i class='fas fa-road'></i> : "
											+ result.routes[0].legs[0].distance.text
											+ ".<br />Duration <i class='fas fa-hourglass-start'></i> : "
											+ result.routes[0].legs[0].duration.text
											+ ".</div>";

									//display route
									directionsDisplay.setDirections(result);
								} else {
									//delete route from map
									directionsDisplay.setDirections({
										routes : []
									});

									map.setCenter(myLatLng);

									//show error message
									output.innerHTML = "<div class='alert-danger'><i class='fas fa-exclamation-triangle'></i> Could not retrieve driving distance.</div>";
								}
							});

		}

		//create autocomplete objects for all inputs
		var options = {
			types : [ '(cities)' ]
		}

		var input1 = document.getElementById("from");
		var autocomplete1 = new google.maps.places.Autocomplete(input1, options);

		var input2 = document.getElementById("to");
		var autocomplete2 = new google.maps.places.Autocomplete(input2, options);
	</script>
</body>
</html>



