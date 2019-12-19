const express = require('express')
const app = express()
const port = 3000

app.use(express.json());       
app.use(express.urlencoded()); 

var userLoggedIn = false;
var todoList = [];
var idGenerator = 0;

app.post('/login', function (req, res) {
	var params = req.body;
	var username = params.username;
	var password = params.password;

	if (username == 'bwa' && password == '123') {
		userLoggedIn = true;
	} else {
		res.json({success : false});
		return;
	}

	res.json({success : true});
})

app.get('/todo', function(req, res) {
	if (!userLoggedIn) {
		res.json({success:false});
	} else {
		res.json({data : todoList});
	}
})

app.post('/todo', function(req, res) {
	if (!userLoggedIn) {
		res.json({success:false});
	} else {
		var params = req.body;
		var topic = params.topic;
		var content = params.content;
		var date = params.date;
		var id = params.id || idGenerator++;
		var todoItem = {
			id, topic, content, date
		};
		if (params.id) {
			var index = null;
			todoList.forEach(function (value, i){ 
				if (value.id == id) {
					index = i;
					return;
				} 
			})

			if (index != null)  {
				todoList.splice(index, 1);
			}
		} 

		todoList.push(todoItem);
		res.json({item : todoItem});
	}
})


app.delete('/todo', function(req, res) {
	if (!userLoggedIn) {
		res.json({success:false});
	} else {
		var id = req.header('data');
		var index = null;
		todoList.forEach(function (value, i){ 
			if (value.id == id) {
				index = i;
				return true;
			} 
		})

		if (index == null) {
			res.json({success:false});
		} else {
			todoList.splice(index, 1);
			res.json({success:true});
		}
	}
})




app.listen(port, () => console.log(`Example app listening on port ${port}!`))