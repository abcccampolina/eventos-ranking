// Visit The Stimulus Handbook for more details 
// https://stimulusjs.org/handbook/introduction
// 
// This custom generate is created by @warleyolf
// 
// This example controller works with specially annotated HTML like:
//
// <div data-controller="eventos">
//   <h1 data-target="eventos.output"></h1>
// </div>

import { Controller } from "stimulus";
import swal from 'sweetalert';
import Rails from '@rails/ujs';

import $ from 'jquery';
import '../custom-modules/multi-select/jquery.multi-select'
import '../custom-modules/multi-select/multi-select.css'

// import "custom-modules/bootstrap-datepicker";
// import "custom-modules/bootstrap-datepicker/dist/locales/bootstrap-datepicker.pt-BR.min.js";


export default class extends Controller {
  // static targets = [ "output" ]

  connect() {
    if(this.data.has("actionForm")){
      this.load_form(this.data.get("actionForm"))
    }
    new Inputmask(undefined, {alias: "datetime", inputFormat: "dd/mm/yyyy"}).mask(
      Array.from(document.getElementsByClassName("datepicker"))
    );
  }

  load_form(action) {
  	$('#evento_user_ids').multiSelect();
  }

  addTemplateFields(event){
    event.preventDefault()
    document.getElementById("juris-fields-template").insertAdjacentHTML('beforeend', event.target.dataset.fields)
  }

  removeTemplateFields(event){
    event.preventDefault()
    event.target.closest('.nested-fields').remove()
  }

  delete(event) {
    console.log(event);
    const id = event.target.dataset.id || event.target.closest("a").dataset.id;
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
        fetch(`/eventos/${id}`, {
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
  } // Delete


  delete_juri(event) {
    console.log(event);
    const id = event.target.dataset.id || event.target.closest("a").dataset.id;
    swal({
      title: "Você tem certeza que deseja remover o Jurado ?",
      text: "Não será possível recuperar esses dados!",
      icon: "warning",
      showCancelButton: true,
      buttons: true,
      // confirmButtonColor: "#DD6B55",
      confirmButtonText: "Sim, quero remover!",
      dangerMode: true,
    }).then((willDelete) => {
      if (willDelete) {
        fetch(`/competicao_juris/${id}`, {
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
  } // Delete

}
