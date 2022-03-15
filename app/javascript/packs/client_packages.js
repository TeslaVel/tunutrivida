document.addEventListener('turbolinks:load', () => {
	$(document).on('change','#billing_patient_id',function(e){
		let patient_id = e.target.value;

		get_client_packages(patient_id);
	})


	function get_client_packages(patient_id) {
	  if ( patient_id && patient_id != '' ) {
			let url = `/patients/${patient_id}/packagesjson`;
			$.ajax({
				url: url,
				tyle : 'get',
				dataType : 'json',
				success: function(data) {
					console.log("pacakges es",data);
				},
				error: function(e) {
				    console.log('failure');
				    console.log(e);
				}
			});
	  }
	}
})