class MainViewController < UIViewController
  def initWithNibName(nibName, bundle: bundleName)
    super
    
    tabWidth = self.view.frame.size.width * 0.9
    tabWidthSpacer = 5
    pointX = (self.view.frame.size.width - tabWidth) / 2
    screen_height = UIScreen.mainScreen.bounds.size.height

    p "#{tabWidth}, #{tabWidthSpacer}, #{pointX}, #{screen_height}"

    # adding logo label
    magicViewsLabel = UILabel.alloc.initWithFrame [[0,10],[self.view.frame.size.width, 30]]
    magicViewsLabel.setTextAlignment UITextAlignmentCenter
    magicViewsLabel.setText "Magic Tabs"
    magicViewsLabel.setFont UIFont.fontWithName("Helvetica", size:24)
    magicViewsLabel.setBackgroundColor UIColor.clearColor
    magicViewsLabel.setTextColor UIColor.whiteColor
    self.view.addSubview magicViewsLabel

    self.view.setBackgroundColor UIColor.scrollViewTexturedBackgroundColor

    tabZ = 0
    magicView_1 = MagicView.alloc.initWithFrame [[pointX - (tabWidthSpacer * 0.5) * tabZ,200],[tabWidth + tabWidthSpacer * tabZ,screen_height]]
    magicView_1.setBackgroundColor UIColor.colorWithRed(246.0/255, green:246.0/255, blue:246.0/255, alpha:1)
    magicView_1.set_z_index tabZ
    magicView_1.set_view_title "First"
    self.view.addSubview magicView_1

    tabZ = 1
    magicView_2 = MagicView.alloc.initWithFrame [[pointX - (tabWidthSpacer * 0.5) * tabZ,250],[tabWidth + tabWidthSpacer * tabZ,screen_height]]
    magicView_2.setBackgroundColor UIColor.colorWithRed(246.0/255, green:246.0/255, blue:246.0/255, alpha:1)
    magicView_2.set_z_index tabZ
    magicView_2.set_view_title "Second"
    self.view.addSubview magicView_2

    tabZ = 2
    magicView_3 = MagicView.alloc.initWithFrame [[pointX - (tabWidthSpacer * 0.5) * tabZ,300],[tabWidth + tabWidthSpacer * tabZ,screen_height]]
    magicView_3.setBackgroundColor UIColor.colorWithRed(246.0/255, green:246.0/255, blue:246.0/255, alpha:1)
    magicView_3.set_z_index tabZ
    magicView_3.set_view_title "Third"
    self.view.addSubview magicView_3

    p "frame #{magicView_3.frame.size.width}, = #{tabWidth + tabWidthSpacer * tabZ}" 
    #
    # adding content to magic views
    #

    # first magiv tab
    magic_content_1 = UIView.alloc.initWithFrame magicView_1.frame
    magic_content_1.frame[0][1] -= 44
    magic_content_1.frame[1][1] -= 44
    label = UILabel.alloc.initWithFrame [[10, 5],[magicView_1.frame.size.width,20]]
    label.setText "Content View!"
    label.setBackgroundColor UIColor.clearColor
    label.sizeToFit

    textField = UITextField.alloc.initWithFrame [[10,25],[200,25]]
    textField.setBorderStyle UITextBorderStyleRoundedRect

    magic_content_1.addSubview label
    magic_content_1.addSubview textField
    magicView_1.set_content_view magic_content_1

    #second magic tab
    layout = UICollectionViewFlowLayout.alloc.init
    layout.setItemSize [50, 100]

    collectionView = UICollectionView.alloc.initWithFrame([[5,50],[magicView_2.frame.size.width - 5, 100]], collectionViewLayout:layout)
    collectionView.setDelegate self
    collectionView.setDataSource self
    collectionView.registerClass(UICollectionViewCell, forCellWithReuseIdentifier:"collectionReuseID")
    magicView_2.set_content_view collectionView

    #third magic tab
    tableView = UITableView.alloc.initWithFrame magicView_3.frame
    tableView.registerClass(UITableViewCell, forCellReuseIdentifier:"cellReuseID")
    tableView.frame[0][1] -= 44
    tableView.frame[1][1] -= 44
    tableView.setDelegate self
    tableView.setDataSource self
    magicView_3.set_content_view tableView

    self
  end

  def collectionView(collectionView, cellForItemAtIndexPath:indexPath)
    data = ["first", "second", "third", "fourth", "fifth"]
    cell = collectionView.dequeueReusableCellWithReuseIdentifier("collectionReuseID", forIndexPath:indexPath)
  
    label = UILabel.alloc.initWithFrame CGRectZero
    label.setText data[indexPath.row]
    label.setBackgroundColor UIColor.clearColor
    label.sizeToFit
    cell.contentView.addSubview label

    cell.setBackgroundColor UIColor.blueColor
    cell
  end

  def collectionView(collectionView, numberOfItemsInSection:section)
    return 5
  end

  def collectionView(collectionView, layout:layout, sizeForItemAtIndexPath:indexPath)
    return [100,50]
  end

  def tableView(tableView, numberOfRowsInSection:section)
    return 5
  end

  def tableView(tableView, cellForRowAtIndexPath:indexPath)
    data = ["first", "second", "third", "fourth", "fifth"]
    cell = tableView.dequeueReusableCellWithIdentifier("cellReuseID", forIndexPath:indexPath)
    cell.textLabel.setText data[indexPath.row]
    cell
  end
end