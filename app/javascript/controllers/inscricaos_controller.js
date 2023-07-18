// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This custom generate is created by @warleyolf
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="inscricaos">
//   <h1 data-target="inscricaos.output"></h1>
// </div>

import {Controller} from "stimulus";
import swal from "sweetalert";
import Rails from "@rails/ujs";
import Inputmask from "inputmask";

import "../stylesheets/select2/select2.min.css";
import "select2/dist/js/select2.full.min";
import "select2/dist/js/i18n/pt-BR.js";

export default class extends Controller {
  // static targets = [ "output" ]

  connect() {
    // document.getElementById("cpf_criador") &&
    //   new Inputmask("999.999.999-99").mask(
    //     document.getElementById("cpf_criador")
    //   );
    // document.getElementById("cpf_expositor") &&
    //   new Inputmask("999.999.999-99").mask(
    //     document.getElementById("cpf_expositor")
    //   );
    this.load_animal()
    this.load_expositor()
  }

  load_form() {
    new Inputmask("999.999.999-99").mask(
      document.getElementById("cpf_criador")
    );
    new Inputmask("999.999.999-99").mask(
      document.getElementById("cpf_expositor")
    );
  }

  putaqpariu(e) {
    console.log("Meu dedinho");
  }

  copiaValor(e) {
    var cpf = document.getElementById("cpf_criador").value;
    var nome_criador = document.getElementById("nome_criador").value;
    var email_criador = document.getElementById("email_criador").value;
    var cidade_criador = document.getElementById("cidade_criador").value;
    var uf_criador = document.getElementById("uf_criador").value;

    document.getElementById("cpf_expositor").value = cpf;
    document.getElementById("nome_expositor").value = nome_criador;
    document.getElementById("email_expositor").value = email_criador;
    document.getElementById("cidade_expositor").value = cidade_criador;
    document.getElementById("uf_expositor").value = uf_criador;
    e.preventDefault();
  }
  
  load_animal() {
    $("#nome_animal").select2({
      language: "pt-BR",
      data: gon.animal,
      minimumInputLength: 3,
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
        inputTooShort: function () {
          return "Insira no mínimo 3 caracteres para para realizar a busca";
        }
      },
    });
  }

  load_expositor() {
    $("#expositor_id_nome").select2({
      language: "pt-BR",
      minimumInputLength: 3,
      ajax: {
        url: "/procurar_expositor",
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
        return $(`<strong>${data.nome || ""}</strong>`);
      },
      language: {
        noResults: function () {
          return "Expositor não encontrado entre em contato no número (31) 3372-7478.";
        },
        inputTooShort: function () {
          return "Insira no mínimo 3 caracteres para para realizar a busca";
        }
      },
      templateSelection: (data) => {
        console.log("Pessoa Selecionada: ", data);
        !data.selected && data.nome     != undefined && (document.getElementById(`expositor_nome`).value = data.nome)
        !data.selected && data.cpf      != undefined && (document.getElementById(`expositor_cpf`).value = data.cpf)
        !data.selected && data.email    != undefined && (document.getElementById(`expositor_email`).value = data.email)
        !data.selected && data.fazenda  != undefined && (document.getElementById(`expositor_fazenda`).value = data.fazenda)
        !data.selected && data.cidade   != undefined && (document.getElementById(`expositor_cidade`).value = data.cidade)
        // !data.selected && data.id    != undefined && (document.getElementById(`expositor_id`).value = data.id)
        return data.nome;
      }
    });

    $("#expositor_id_select").select2({
      language: "pt-BR",
      minimumInputLength: 3,
      ajax: {
        url: "/procurar_expositor_pessoas",
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
        return $(`<strong>${data.nome_pessoa || ""}</strong>`);
      },
      language: {
        noResults: function () {
          return "Expositor não encontrado entre em contato no número (31) 3372-7478.";
        },
        inputTooShort: function () {
          return "Insira no mínimo 3 caracteres para para realizar a busca";
        }
      },
      templateSelection: (data) => {
        console.log("Pessoa Selecionada: ", data);
        return data.nome_pessoa;
      }
    });
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
        fetch(`/inscricaos/${id}`, {
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
