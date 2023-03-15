<script lang="ts">
  function countUp() {
    window.nodecg.sendMessage('countUp')
  }
</script>

<button on:click={countUp}>Count up</button>
