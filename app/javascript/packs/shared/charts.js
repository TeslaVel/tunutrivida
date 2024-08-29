document.addEventListener('turbolinks:load', () => {
	Chart.defaults.global.defaultFontFamily = 'Nunito', '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
  Chart.defaults.global.defaultFontColor = '#858796';


	function number_format_patient(number, decimals, dec_point, thousands_sep) {
    number = (number + '').replace(',', '').replace(' ', '');
    var n = !isFinite(+number) ? 0 : +number,
      prec = !isFinite(+decimals) ? 0 : Math.abs(decimals),
      sep = (typeof thousands_sep === 'undefined') ? ',' : thousands_sep,
      dec = (typeof dec_point === 'undefined') ? '.' : dec_point,
      s = '',
      toFixedFix = function(n, prec) {
        var k = Math.pow(10, prec);
        return '' + Math.round(n * k) / k;
      };
    // Fix for IE parseFloat(0.55).toFixed(0) = 0;
    s = (prec ? toFixedFix(n, prec) : '' + Math.round(n)).split('.');
    if (s[0].length > 3) {
      s[0] = s[0].replace(/\B(?=(?:\d{3})+(?!\d))/g, sep);
    }
    if ((s[1] || '').length < prec) {
      s[1] = s[1] || '';
      s[1] += new Array(prec - s[1].length + 1).join('0');
    }
    return s.join(dec);
  }

  setBarChart = function (xValues,yValues,elementDiv,maxYAxesValues = '10',simbol = '$ ') {

		// Bar Chart Example
	  let ctx = document.getElementById(elementDiv);

	  if (!ctx) return;

	  let myBarChart = new Chart(ctx, {
	    type: 'bar',
	    data: {
	      labels: xValues ,
	      datasets: [{
	        label: `${simbol}: `,
	        backgroundColor: "#4e73df",
	        hoverBackgroundColor: "#2e59d9",
	        borderColor: "#4e73df",
	        data: yValues,
	      }],
	    },
	    options: {
	      maintainAspectRatio: false,
	      layout: {
	        padding: {
	          left: 10,
	          right: 25,
	          top: 25,
	          bottom: 0
	        }
	      },
	      scales: {
	        xAxes: [{
	          time: {
	            unit: 'days'
	          },
	          gridLines: {
	            display: false,
	            drawBorder: false
	          },
	          ticks: {
	            maxTicksLimit: 10
	          },
	          maxBarThickness: 35,
	        }],
	        yAxes: [{
	          ticks: {
	            min: 1,
	            max: maxYAxesValues,
	            maxTicksLimit: 5,
	            padding: 0,
	            // Include a dollar sign in the ticks
	            callback: function(value, index, values) {
	              return `${simbol} (${value})`;
	            }
	          },
	          gridLines: {
	            color: "rgb(234, 236, 244)",
	            zeroLineColor: "rgb(234, 236, 244)",
	            drawBorder: false,
	            borderDash: [2],
	            zeroLineBorderDash: [2]
	          }
	        }],
	      },
	      legend: {
	        display: false
	      },
	      tooltips: {
	        titleMarginBottom: 10,
	        titleFontColor: '#6e707e',
	        titleFontSize: 14,
	        backgroundColor: "rgb(255,255,255)",
	        bodyFontColor: "#858796",
	        borderColor: '#dddfeb',
	        borderWidth: 1,
	        xPadding: 15,
	        yPadding: 15,
	        displayColors: false,
	        caretPadding: 10,
	        callbacks: {
	          label: function(tooltipItem, chart) {
	            let datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
	            return datasetLabel + tooltipItem.yLabel;
	          }
	        }
	      },
	    }
	  });
	}

	setAreaChart = function(
		xValues,
		yValues,
		elementDiv,
		minYvalue = 5,
		maxYValue = 10,
		maxXTicks = 6,
		simbol = '$ ') {
			let ctx = document.getElementById(elementDiv);

		  if (!ctx) return;

		  let myLineChart = new Chart(ctx, {
		    type: 'line',
		    data: {
		      labels: xValues,
		      datasets: [{
		        label: `${simbol}: `,
		        lineTension: 0.3,
		        backgroundColor: "rgba(78, 115, 223, 0.05)",
		        borderColor: "rgba(78, 115, 223, 1)",
		        pointRadius: 5,
		        pointBackgroundColor: "rgba(78, 115, 223, 1)",
		        pointBorderColor: "rgba(78, 115, 223, 1)",
		        pointHoverRadius: 3,
		        pointHoverBackgroundColor: "rgba(78, 115, 223, 1)",
		        pointHoverBorderColor: "rgba(78, 115, 223, 1)",
		        pointHitRadius: 10,
		        pointBorderWidth: 2,
		        data: yValues
		      }],
		    },
		    options: {
		      maintainAspectRatio: false,
		      layout: {
		        padding: {
		          left: 2,
		          right: 2,
		          top: 2,
		          bottom: 0
		        }
		      },
		      scales: {
		        xAxes: [{
		          time: {
		            unit: 'date'
		          },
		          gridLines: {
		            display: false,
		            drawBorder: false
		          },
		          ticks: {
		            maxTicksLimit: maxXTicks
		          }
		        }],
		        yAxes: [{
		          ticks: {
		          	min: minYvalue,
		          	max: maxYValue + 5,
		            maxTicksLimit: 6,
		            padding: 5,
		            // Include a dollar sign in the ticks
		            callback: function(value, index, values) {
		              return `${simbol} ${value}`;
		            }
		          },
		          gridLines: {
		            color: "rgb(234, 236, 244)",
		            zeroLineColor: "rgb(234, 236, 244)",
		            drawBorder: false,
		            borderDash: [2],
		            zeroLineBorderDash: [2]
		          }
		        }],
		      },
		      legend: {
		        display: false
		      },
		      tooltips: {
		        backgroundColor: "rgb(255,255,255)",
		        bodyFontColor: "#858796",
		        titleMarginBottom: 10,
		        titleFontColor: '#6e707e',
		        titleFontSize: 14,
		        borderColor: '#dddfeb',
		        borderWidth: 1,
		        xPadding: 15,
		        yPadding: 15,
		        displayColors: false,
		        intersect: false,
		        mode: 'index',
		        caretPadding: 10,
		        callbacks: {
		          label: function(tooltipItem, chart) {
		            var datasetLabel = chart.datasets[tooltipItem.datasetIndex].label || '';
		            return datasetLabel + tooltipItem.yLabel;
		          }
		        }
		      }
		    }
		  });
	}
})