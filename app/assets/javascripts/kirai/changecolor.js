<script>
    var div1 = document.getElementById('vote');
    for (let i= 0; i < div1.length; i++){
        div1.addEventListener('click',function(e){
            div1[i].style.backgroundcolor = 'darkgrey';
    },false)
    }
</script>