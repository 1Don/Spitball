var currentItem;
function allowDrop(ev) {
  ev.preventDefault();
}

function drag(ev) {
  currentItem = ev.target;
}

function drop(ev) {
  ev.preventDefault();
  ev.stopPropagation();
  console.log(ev.target);
  $(ev.target).before(currentItem)
}
