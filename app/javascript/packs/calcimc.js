document.addEventListener('turbolinks:load', () => {
	let imc = 0;
	let h2 = 0;
	let weight = 0;
	let height = 0;
	let ideal_weight = 0;

	function recalcular_imc() {
		weight = 0;
		height = 0;
		ideal_weight = 0;
		imc = 0;
		h2 = 0;

		height = $("#session_height").val().trim();
		weight = $("#session_weight").val().trim();
		if (weight != '' && height != '')
		{
			h2 = (height*height).toFixed(2);
			imc = (weight / h2 ).toFixed(2);
			ideal_weight = (imc * h2 ).toFixed(2);
			console.log("weight",weight);
			console.log("height",height);
			console.log("imc",imc);
			console.log("h2",h2);
			$("#session_imc").val(imc);
			$("#session_ideal_weight").val(ideal_weight);

		} else {$("#session_imc").val('')}
	}

	$(document).on('keyup','#session_height',function(e){
		recalcular_imc();
	})

	$(document).on('keyup','#session_weight',function(e){
		recalcular_imc();
	})

	$(document).on('keyup','#session_imc',function(e){
		weight = 0;
		height = 0;
		ideal_weight = 0;
		imc = 0;
		h2 = 0;

		imc = $("#session_imc").val().trim();
		height = $("#session_height").val().trim();
		weight = $("#session_weight").val().trim();
		if (weight != '' && height != '')
		{
			h2 = (height*height).toFixed(2);
			ideal_weight = (imc * h2 ).toFixed(2);
			$("#session_ideal_weight").val(ideal_weight);
		} else {$("#session_ideal_weight").val('')}
	})




	function load_imc_chart_bar() {
	  let patient_id = $("#package_patient_view_patient_id").val();
	  let patient_package_id = $("#package_patient_view_package_id").val();

	  if (patient_id && patient_id != '' && patient_package_id && patient_package_id != '' ) {
			let url = `/patients/${patient_id}/packages/${patient_package_id}/sessions/sessionsjson`;
		  $("#patient_graph_bar").removeClass('d-none');
			$.ajax({
				url: url,
				tyle : 'get',
				dataType : 'json',
				success: function(data) {
				  setAreaChart(data.days,data.imc_values,'patientImcBar',data.max_imc_value,'Imc');
				},
				error: function(e) {
				    console.log('failure');
				    console.log(e);
				}
			});
	  }
	}
	load_imc_chart_bar();
	

})