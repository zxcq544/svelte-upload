<script>
  let files_array = [];
  let file_input;
  let index;
  let images = [];
  function send_click_to_input() {
    file_input.click();
  }
  function remove_from_files(i) {
    console.log("files array before remove", files_array);
    index = i;
    console.log("index which to remove", index);
    files_array.splice(index, 1);
    images.splice(index, 1);
    files_array = files_array;
    images = images;
    console.log("files array after remove", files_array);
  }
  function remove_all() {
    files_array = [];
    images = [];
  }
  async function add_to_files_array() {
    console.log("on change FilesList", file_input.files);
    files_array = [...files_array, ...file_input.files];
    console.log("on change files array", files_array);
    Promise.all(files_array.map(my_readAsDataURL)).then((values) => {
      images = values;
    });
  }
  function my_readAsDataURL(file) {
    return new Promise(function (resolve, reject) {
      let fr = new FileReader();
      fr.onload = function () {
        resolve(fr.result);
      };
      fr.onerror = function () {
        reject(fr);
      };
      fr.readAsDataURL(file);
    });
  }
</script>

<input
  type="file"
  style="display: none"
  bind:this={file_input}
  multiple
  onclick="this.value=null;"
  on:change={add_to_files_array}
/>

<button on:click={send_click_to_input}>
  <span>Add Files</span>
</button>
<button class="remove" on:click={remove_all}> Remove All </button>
<div style="display:flex">
  {#if files_array && files_array[0]}
    {#each files_array as file, i}
      <div class="image_block">
        <!--         <span>
          {file.name}
        </span> -->
        <!-- 				{#await load_preview()} -->
        <!-- 				<span>loading...</span>}
				{:then values} -->
        <img src={images[i]} alt="" />
        <button class="remove_cross" on:click={() => remove_from_files(i)}>
          X
        </button>
        <!-- 				{:catch error}
					<p style="color: red">{error.message}</p>
				{/await} -->
      </div>
    {/each}
  {/if}
</div>

<style>
  .image_block {
    display: flex;
    flex-wrap: nowrap;
    flex-direction: row;
    align-content: center;
    justify-content: flex-start;
    align-items: flex-start;
    margin: 4px;
  }
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
    box-shadow: 1px 1px 2px indigo;
    background-color: blueviolet;
    border-color: blueviolet;
    padding: 0px;
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
    margin-left: -18px;
    font-size: 10px;
    line-height: 0px;
    vertical-align: middle;
    border-radius: 0px;
  }
  span {
    font-size: 18px;
  }
  img {
    width: 100px;
  }
</style>
