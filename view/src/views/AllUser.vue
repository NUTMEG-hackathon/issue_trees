<template>
	<div id="app" class="container-fluid">
		<div class="panel panel-default">
		<h1 style="color:#333333">ALL User information</h1>
		<v-row>
			<v-col cols ="1" />
				<v-col cols = "9" >
					<v-data-table
						:headers="headers"
						:items="this.userDetails"
						:items-per-page="10"
						:search="search"
					
					>
						<template v-slot:top>
							<v-text-field
							append-icon="mdi-magnify"
							v-model="search"
							label="Search"
							class="mx-1"
							></v-text-field>
						</template>
					</v-data-table>
				</v-col>
			<v-col cols ="1" />
		</v-row>				
	</div>
	</div>
</template>


<script>
import axios from 'axios'
export default {
	data() {
		return{
			search: '',
			users: [],
			user:[],
			userDetails: [],
			tmpUserDetails:[],
			userSkills: [],
			skillName: [],
			projectName: [],
			userName: [],
			userLength: [],
			projectLength: [],

			headers :[
				{
					text: 'Username',
					align: 'start',
					sortable: 'false',
					value: 'user_name',
					width: `15%`
				},
				{
					text: 'Userskills',
					align: 'start',
					sortable: 'false',
					value: 'skills',
					width: `25%`
				},
				{
					text: 'Userproject',
					align: 'start',
					sortable: 'false',
					value: 'projects',
					width: `60%`
				}

			]
		}
	},
	methods :{
		
	},
	mounted() {
		const url = process.env.VUE_APP_URL + "/api/v1/users/index";
		axios
			.get(url, {
				headers: {
					"Content-Type": "application/json",
					"access-token": localStorage.getItem("access-token"),
					client: localStorage.getItem("client"),
					uid: localStorage.getItem("uid"),
				},
			})
			.then((response) => {
				this.users = response.data.data;
		});

		const userurl = process.env.VUE_APP_URL + "/api/v1/get_details";
		axios
			.get(userurl, {
				headers: {
					"Content-Type": "application/json",
					"access-token": localStorage.getItem("access-token"),
					client: localStorage.getItem("client"),
					uid: localStorage.getItem("uid"),
				},
			})
			.then((response) => {
				console.log(response.data)
				this.userDetails = response.data
			}
		);
	},
};

</script>,
