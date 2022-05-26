### Colourized bash prompt

#### Uses colour for easy visual parsing


Colourized bash prompt
* Displays time of last command in top-right corner of screen
* Displays `user@host [working-directory]`
* Displays current git branch, if in git working repo, on next line


Modify `~/.bashrc`:
* "Source" (run) colourize-prompt.sh near end of file

Or:

* Place the `define_colours` function before prompt is set
* Place `git_branch` function before prompt is set
* Set `force_color_prompt` to `yes`:
	* `force_color_prompt=yes`
* Set prompt (lines containing `PS1=...`)

![Screenshot_1](https://user-images.githubusercontent.com/36019446/170593991-247859cb-9170-432f-917d-2f51e065e329.png)
