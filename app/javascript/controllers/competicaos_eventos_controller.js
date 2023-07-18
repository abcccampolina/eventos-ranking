// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This custom generate is created by @warleyolf
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="competicaos_eventos">
//   <h1 data-target="competicaos_eventos.output"></h1>
// </div>

import { Controller } from "stimulus"
import swal from 'sweetalert';
import Rails from '@rails/ujs';


export default class extends Controller {
  // static targets = [ "output" ]

  connect() {
    if(this.data.has("actionForm")){
      this.load_form(this.data.get("actionForm"))
    }
  }

  load_form(action) {
  	// on load form
  }


  delete_inscricao(event) {
    const id = event.target.dataset.value;
    swal({
      title: "Você tem certeza?",
      text: "Não será possível recuperar esses dados!",
      icon: "warning",
      showCancelButton: true,
      buttons: true,
      // confirmButtonColor: "#DD6B55",
      confirmButtonText: "Sim, quero remover!",
      dangerMode: true,
    }).then((willDelete) => {
      if (willDelete) {
        fetch(`/inscricaos_competicaos/${id}`, {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": Rails.csrfToken(),
          },
          body: JSON.stringify({
            _method: "delete",
          }),
        }).then((response) => {
          console.log(response);
          if (response.ok) {
            swal("Excluido!", "Os dados foram eliminados.", "success");
          } else {
            swal("Erro!", "Os dados não foram excluidos.", "error");
          }
        });
      }
    });
  } // Delete Inscricao

  delete(event) {
  	const id = event.target.dataset.value || event.target.closest("a").dataset.id;
  	swal({
		title: "Você tem certeza?",
		text: "Não será possível recuperar esses dados!",
		icon: "warning",
		showCancelButton: true,
		buttons: true,
		// confirmButtonColor: "#DD6B55",
		confirmButtonText: "Sim, quero remover!",
		dangerMode: true
	}).then((willDelete) => {
		if(willDelete){
			fetch(`/competicaos_eventos/${id}`, {
				method: "DELETE",
				headers: {
					'Content-Type': 'application/json',
					'X-CSRF-Token': Rails.csrfToken()
				},
				body: JSON.stringify({
					"_method": "delete"
				})
			}).then( (response) => {
				console.log(response);
				if(response.ok){
					swal("Excluido!", "Os dados foram eliminados.", "success");
				} else {
					swal("Erro!", "Os dados não foram excluidos.", "error");
				}
			});
		}
	});
  } // Delete
}
