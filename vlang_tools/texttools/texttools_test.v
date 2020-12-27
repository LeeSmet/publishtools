module texttools
import json

fn test_dedent(){

	mut text:='
		a
			b

			c
		d
		

	'
	text = dedent(text)
	// println("'$text'")
	assert text.len==20
}



fn test_multiline_to_single(){

	mut text:="
		id:a1
		name:'need to do something 1'
		description:
			## markdown works in it

			description can be multiline
			lets see what happens

			- a
			- something else

			### subtitle

			```python
			#even code block in the other block, crazy parsing for sure
			def test():
				print()
			```
	"
	text = multiline_to_single(text) or {panic(err)}


	mut required_result:="
	id:a1
	name:'need to do something 1'
	description:'## markdown works in it\\n\\ndescription can be multiline\\nlets see what happens\\n\\n- a\\n- something else\\n\\n### subtitle\\n\\n```python\\n#even code block in the other block, crazy parsing for sure\\ndef test():\\n    print()\\n```'
	"
	assert dedent(required_result).trim_space() == dedent(text).trim_space()

}


fn test_multiline_to_params(){

	mut text:="
		id:a1 name6:aaaaa
		name:'need to do something 1' 
		description:
			## markdown works in it

			description can be multiline
			lets see what happens

			- a
			- something else

			### subtitle

			```python
			#even code block in the other block, crazy parsing for sure
			def test():
				print()
			```

		name2 :   test
		name3: hi name10 :'this is with space'  name11:aaa11

		#some comment

		name4 : 'aaa'

		//somecomment
		name5 :   'aab' 
	"

	expectedresult := texttools.TextParams{
		params: [texttools.TextParam{
			key: 'id'
			value: 'a1'
		}, texttools.TextParam{
			key: 'name6'
			value: 'aaaaa'
		}, texttools.TextParam{
			key: 'name'
			value: 'need to do something 1'
		}, texttools.TextParam{
			key: 'description'
			value: '## markdown works in it

description can be multiline
lets see what happens

- a
- something else

### subtitle

```python
#even code block in the other block, crazy parsing for sure
def test():
	print()
```
'
		}, texttools.TextParam{
			key: 'name2'
			value: 'test'
		}, texttools.TextParam{
			key: 'name3'
			value: 'hi'
		}, texttools.TextParam{
			key: 'name10'
			value: 'this is with space'
		}, texttools.TextParam{
			key: 'name11'
			value: 'aaa11'
		}, texttools.TextParam{
			key: 'name4'
			value: 'aaa'
		}, texttools.TextParam{
			key: 'name5'
			value: 'aab'
		}]
	}	

	// expectedresult

	params := text_to_params(text) or {panic(err)}

	//need to replace /t because of the way how I put the expected result in code here
	assert json.encode(params)== json.encode(expectedresult).replace("\\t","    ")

}