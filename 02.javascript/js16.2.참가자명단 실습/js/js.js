const cname = document.querySelector("#cname"); 
const major = document.querySelector("#major"); 
const save = document.querySelector("#save");
const bbb= document.getElementById("chilist") ; 





save.addEventListener("click", (e) => {
const tr = document.createElement("tr"); 
const tdname = document.createElement("td"); 
const tdmajor = document.createElement("td"); 
const tddel = document.createElement("td"); 
const delButtons = document.createElement("button")
const a=document.createTextNode("삭제");
delButtons.appendChild(a);
  e.preventDefault();
  delButtons.addEventListener("click", (e) => {
    tr.remove();
  } )
  tdname.innerHTML = cname.value
  tdmajor.innerHTML = major.value

  tr.appendChild(tdname);
  tr.appendChild(tdmajor);
  tr.appendChild(delButtons);
  chilist.appendChild(tr);




    



});
