#Magic tabs

Available on [Objective-C](https://github.com/savytskyi/MagicTabsObjC) and [RubyMotion](https://github.com/savytskyi/magic_tabs_rubymotion)

![MagicTabs screenshot](https://raw.github.com/savytskyi/magic_tabs_rubymotion/master/magicTabs.jpg)

#How to use

Add MagicView.rb file to your project. Every tab is just an instance of MagicView class.
If you want 2 tabs, just create 2 instances of MagicView. Want 5? Create 5.

	magicTab = MagicView.alloc.initWithFrame [[x,y],[width,height]]
	
MagicTab's frame is important. If you want more than one magic tab, remember that every new tab should be created with:

- higher WIDTH value (if we don't want them to be like on a screenshot, with a different width)
- smaller X value (if we want to center it)
- higher Y value (every new tab should be placed below previous tab, right?) 

Now we need to assign z index to our tabs:

	magic_tab.set_z_index 1
	
![MagicTabs sizes](https://raw.github.com/savytskyi/magic_tabs_rubymotion/master/sizes.jpg)

Now we can add each tab's title and content views. You can use any UIView for a content, but it would be great if its frame will be equal to magicTab's frame.

	magicTab.set_view_title "Cool Title"
	
	#adding tableView as a content
	
	new_frame = [[0,0], [magicTab.frame.size.width, magicTab.frame.size.height]]
	tableView = UITableView.alloc.initWithFrame new_frame
    tableView.registerClass(UITableViewCell, forCellReuseIdentifier:"cellReuseID")
    tableView.setDelegate self
    tableView.setDataSource self
    magicTab.set_content_view tableView
    
And don't forget to add magit tab to your view

    self.view.addSubview magicTab