<script>
  let files;
  let files_array = [];
  let file_input;
  let index;
  function send_click_to_input() {
    file_input.click();
  }
  function remove_from_files(i) {
    console.log("files array before remove", files_array);
    index = i;
    console.log("index which to remove", index);
    files_array.splice(index, 1);
    files_array = files_array;
    console.log("files array after remove", files_array);
  }
  function remove_all() {
    files_array = [];
  }
  function add_to_files_array() {
    console.log("on change FilesList", files);
    files_array = [...files_array, ...files];
    console.log("on change files array", files_array);
  }
</script>

<input
  type="file"
  style="display: none"
  bind:this={file_input}
  multiple
  bind:files
  on:change={add_to_files_array}
/>

<button on:click={send_click_to_input}>
  <span>Add Files</span>
</button>
<button class="remove" on:click={remove_all}> Remove All </button>
<div>
  {#if files_array && files_array[0]}
    {#each files_array as file, i}
      <div>
        <span>
          {file.name}
        </span>
        <button
          class="remove_cross"
          data-index={i}
          on:click={() => remove_from_files(i)}
        >
          X
        </button>
      </div>
    {/each}
  {/if}
</div>

<style>
  button {
    display: inline-block;
    position: relative;
    box-sizing: border-box;
    text-decoration: none;
    color: #fff;
    width: 100px;
    height: 50px;
    line-height: 30px;
    border-radius: 7%;
    text-align: center;
    vertical-align: middle;
    font-weight: bold;
    box-shadow: 2px 2px 2px indigo;
    background-color: blueviolet;
    border-color: blueviolet;
  }
  button:hover {
    background-color: #985ad2;
    transition: background-color 150ms linear;
  }
  button:active {
    background-color: mediumpurple;
    transform: translate(1px, 1px);
  }
  .remove {
    width: 107px;
    height: 50px;
    line-height: 10px;
    border-radius: 5px;
  }
  .remove_cross {
    width: 18px;
    height: 18px;
    font-size: 10px;
    line-height: 0px;
    vertical-align: middle;
    margin: 0px;
  }
  span {
    font-size: 18px;
  }
</style>
