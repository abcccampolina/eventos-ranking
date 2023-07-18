// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This custom generate is created by @warleyolf
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="inscricaos_competicaos">
//   <h1 data-target="inscricaos_competicaos.output"></h1>
// </div>

import { Controller } from "stimulus"
import swal from "sweetalert";
import Rails from "@rails/ujs";

import "../stylesheets/select2/select2.min.css";
import "select2/dist/js/select2.full.min";
import "select2/dist/js/i18n/pt-BR.js";

export default class extends Controller {
  // static targets = [ "output" ]

  connect() {
    if (this.data.has("actionForm")) {
      this.load_form(this.data.get("actionForm"));
    }
    this.load_animal();
  }

  load_form(action) {
    // on load form
  }

  load_animal() {
    $("#nome_animal").select2({
      language: "pt-BR",
      data: gon.animal,
      ajax: {
        url: "/srg_animals",
        dataType: "json",
        delay: 250,
        data: (params) => {
          return {
            q: params.term, // search term
            page: params.page,
          };
        },
        processResults: (data, params) => {
          return {
            results: data,
          };
        },
      },
      templateResult: (data) => {
        return $(`<strong>${data.nome_completo || ""}</strong>`);
      },
      templateSelection: (data) => {
        console.log("Animal Selected: ", data);
        return data.nome_completo;
      },
      language: {
        noResults: function () {
          return "Animal não encontrado entre em contato no número (31) 3372-7478.";
        },
      },
    });

    $("#nome_animal_pai").select2({
      language: "pt-BR",
      data: gon.animal,
      ajax: {
        url: "/srg_animals",
        dataType: "json",
        delay: 250,
        data: (params) => {
          return {
            q: params.term, // search term
            page: params.page,
          };
        },
        processResults: (data, params) => {
          return {
            results: data,
          };
        },
      },
      templateResult: (data) => {
        console.log(data);
        return $(`<strong>${data.nome_completo || ""}</strong>`);
      },
      templateSelection: (data) => {
        console.log("Animal Selected: ", data);
        return data.nome_completo;
      },
      language: {
        noResults: () => {
          return "Animal não encontrado entre em contato no número (31) 3372-7478.";
        },
      },
    });

    $("#nome_animal_mae").select2({
      language: "pt-BR",
      data: gon.animal,
      ajax: {
        url: "/srg_animals",
        dataType: "json",
        delay: 250,
        data: (params) => {
          return {
            q: params.term, // search term
            page: params.page,
          };
        },
        processResults: (data, params) => {
          return {
            results: data,
          };
        },
      },
      templateResult: (data) => {
        console.log(data);
        return $(`<strong>${data.nome_completo || ""}</strong>`);
      },
      templateSelection: (data) => {
        console.log("Animal Selected: ", data);
        return data.nome_completo;
      },
      language: {
        noResults: () => {
          return "Animal não encontrado entre em contato no número (31) 3372-7478.";
        },
      },
    });
  }

  delete(event) {
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
  } // Delete
}
