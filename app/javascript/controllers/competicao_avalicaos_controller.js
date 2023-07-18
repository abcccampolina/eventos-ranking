// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction
//
// This custom generate is created by @warleyolf
//
// This example controller works with specially annotated HTML like:
//
// <div data-controller="competicao_avalicaos">
//   <h1 data-target="competicao_avalicaos.output"></h1>
// </div>

import {Controller} from "stimulus";
import swal from "sweetalert";
import Rails from "@rails/ujs";
import Inputmask from "inputmask";
import 'jquery';

export default class extends Controller {
  // static targets = [ "navItem" ]

  connect() {
    if (this.data.has("actionForm")) {
      this.load_form(this.data.get("actionForm"));
    }
    // new Inputmask("datetime", {inputFormat: "MM:ss.ms"}).mask(
    new Inputmask("99:99.9999", {}).mask(
      Array.from(document.getElementsByClassName("input-time"))
    );
    // document.addEventListener("nav-link")
  }

  changeElements(event) {
    // return
    var data = document
      .getElementById(`el${event.target.dataset.conector}`)
      .value.split(":")
      .map(Number);
    var total_time = 0;
    if (isNaN(data[0]) || isNaN(data[1])) return;
    total_time += data[0] * 60 + data[1];
    document
      .querySelectorAll(`.co${event.target.dataset.conector}`)
      .forEach((el) => {
        var value = parseInt(el.value);
        if (!isNaN(value)) {
          total_time += value * 5;
        }
      });
    document.getElementById(
      `fn${event.target.dataset.conector}`
    ).innerText = new Date(total_time * 1000).toISOString().substr(14, 5);
  }

  navChange(event) {
    document.querySelectorAll(".nav-item-c").forEach((e) => {
      e.classList.remove("active");
    });
    event.target.parentElement.classList.add("active");

    setTimeout(() => {
      let juri = document.getElementsByClassName('nav-link active')[0].id.split("\n")[0]
      const id = "myTable";
      const selector = `#${id} tr:not(.header)`;
      const trs = document.querySelectorAll(selector);
  
      trs.forEach((tr) => {
        let tds = tr.querySelectorAll("td");
  
        let str = Array.from(tds).map((td) => {
          return td.textContent
        }).join("");
  
        tr.style.display = (str.indexOf(juri) > -1) ? "table-row" : "none";
      });
  
      console.log("FIM DO FLUXO", juri)
    }, 100)
  }

  onPostSuccess(event) {
    console.log(event.target.dataset.key);
    document.getElementById(`it${event.target.dataset.key}`).firstChild.nextSibling.click();
    var elLk = document.getElementById(`lk${event.target.dataset.key}`);
    elLk.classList.remove("text-danger");
    elLk.classList.add("text-success");
    $.notify(
      {
        icon: "nc-icon nc-bell-55",
        message: "Nota atualizada com sucesso",
      },
      {
        type: "success",
        timer: 2000,
        placement: {from: "top", align: "right"},
      }
    );
  }

  onBookPostSuccess() {
    $.notify(
      {
        icon: "nc-icon nc-bell-55",
        message: "Juri de desempate foi atualizado com sucesso",
      },
      {
        type: "success",
        timer: 2000,
        placement: {from: "top", align: "right"},
      }
    );
  }

  async bookSubmitForm(e) {


    
    
    
    const formsObj = document.querySelectorAll(".post-form-nota")
    
    var formsArr = Array.from(formsObj).forEach(async (form) => {
      var formData = new FormData(form)
      var data = await this.sendForm(form, formData)
      })
      
    const spinner = document.getElementById("spinner");
    spinner.style.display = "block";
    var delayInMilliseconds = formsObj.length * 900;

    setTimeout(function() {
      spinner.style.display = "none";
      $.notify({
        icon: "nc-icon nc-bell-55",
        message: "Dados Salvos com Sucesso"
  
      }, {
        type: 'success',
        timer: 1000,
        placement: { from: 'top', align: 'right' }
      });

    }, delayInMilliseconds);

   

  }

  async sendForm(form, formData){
    return await fetch(form.action, {
      method: "POST",
      body: formData
    })
  }

  // changeDesempate(event) {
  //   console.log("Juri trocado para (id):", event.target.value)
  //   const juris = Array.from(document.querySelector(".tab-pane.active").querySelectorAll(".juri-desempate"))

  //   juris.forEach((juri) => {
  //     juri.value = false
  //   })

  //   var juriSelecionado = document.querySelector(".tab-pane.active").querySelectorAll(`juri-desempate[value="${event.target.value}"]`).value = true

  // }

  load_form(action) {
    // on load form
  }

  juri_desempate() {
	$(document).on('change', '#juri_desempate', function(){
		debugger;
		if($(this).prop('checked')){
			$('#juri_desempate').attr('disabled', 'disabled');
		} else {
			$('#juri_desempate').removeAttr('disabled');
		}
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
        fetch(`/competicao_avalicaos/${id}`, {
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
