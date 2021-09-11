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
		console.log(images);
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
		//Loads with readAsDataURL
		Promise.all(files_array.map(read_images)).then((values) => {
			images = values;
		});
	}
	//Loads with readAsDataURL
	function read_images(file) {
		return new Promise((resolve, reject) => {
			let fr = new FileReader();
			fr.onload = () => {
				resolve(fr.result);
			};
			fr.onerror = () => {
				reject(fr);
			};
			fr.readAsDataURL(file);
		});
	}
	function send_files() {
		var form_data = new FormData();
		files_array.map((value) => {
			form_data.append("uploadfile[]", value);
		});
		var request = new XMLHttpRequest();
		request.onload = function (ev) {
			var on_load_complete = document.getElementById("on_load_complete");
			on_load_complete.innerText = "Load Complete Successfully";
			remove_all();
		};
		request.open("POST", "/upload");
		request.send(form_data);
	}
</script>

<input
	type="file"
	accept="image/*"
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
<button on:click={send_files}>Send files</button>
<span id="on_load_complete" />
<div style="display:flex">
	{#if files_array && files_array[0]}
		{#each files_array as file, i}
			<div class="image_block">
				<img src={images[i]} alt="" />
				<button
					class="remove_cross"
					on:click={() => remove_from_files(i)}
				>
					X
				</button>
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
