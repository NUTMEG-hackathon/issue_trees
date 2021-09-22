<template>
	<div id="app" class="container-fluid">
    <div class="panel panel-default">
			<v-btn @click="displayUsers">
				うんち
			</v-btn>
			<v-card v-for="(user, i) in users" :key=i>
				{{ users.length }}
				{{ userSkills.skillnames }}
			</v-card>
			<br />
		</div>
	</div>
</template>

<script>
import axios from 'axios'
export default {
	data() {
		return{
			users: [],
			user:[],
			userSkills: [],
			skillName: [],
			projectName: [],
			userName: [],
			userLength: [],
			projectLength: [],
		}
	},
	methods :{
		displayUsers: async function(){
			for(let i=0 ;i < this.users.length; i++){
				this.user.push(this.users[i])
			}
			this.fetchUserSkills(1);
		},
		
		// fetchUserSkills: async function (user_id) {
    //   var url = process.env.VUE_APP_URL;
		// 	this.skillName = "";
    //   await axios
    //     .get(url + "/api/v1/get_user_skill_details/" + user_id, {
    //       headers: {
    //         "Content-Type": "application/json",
    //         "access-token": localStorage.getItem("access-token"),
    //         client: localStorage.getItem("client"),
    //         uid: localStorage.getItem("uid"),
    //       },
    //     })
    //     .then((response) => {
    //       this.userSkills = response.data[0];
		// 			console.log(this.userSkills.skill_names);
		// 			for(let i = 0; i < this.userSkills.skill_names.length; i++){
		// 				this.skillName += this.userSkills.skill_names[i].skill_name;
		// 				this.skillName += " "
		// 			}
		// 			this.userSkills.skillnames = this.skillName;
		// 			console.log(this.userSkills.skillnames);
    //     });
    // },
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
				// console.log(this.users)
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
				console.log(response.data.length)
				this.userLength = (response.data.length)
				console.log(response.data)
				for(let i =0; i < this.userLength; i++){
					this.projectLength = response.data[i].projects.length
					this.skillLength = response.data[i].skills.length
					this.userName = response.data[i].user_name
					this.userName += " "
					console.log(this.userName)
					for(let j =0; j < this.projectLength; j++ ){
						this.projectName = response.data[i].projects[j].project_name
						this.projectName += " " 
						console.log(this.projectName)
					}
					for(let k=0; k < this.skillLength; k++){
						this.skillName = response.data[i].skills[k].skill_name
						this.skillName += " "
						console.log(this.skillName)
					}
				}
		});
	},
};

</script>,
