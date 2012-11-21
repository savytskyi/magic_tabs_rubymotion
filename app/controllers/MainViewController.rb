class MainViewController < UIViewController
  def initWithNibName(nibName, bundle: bundleName)
    super

    magicViewsLabel = UILabel.alloc.initWithFrame [[0,10],[self.view.frame.size.width, 30]]
    magicViewsLabel.setTextAlignment UITextAlignmentCenter
    magicViewsLabel.setText "Magic Nav Bars"
    magicViewsLabel.setFont UIFont.fontWithName("Helvetica", size:24)
    magicViewsLabel.setBackgroundColor UIColor.clearColor
    magicViewsLabel.setTextColor UIColor.whiteColor
    self.view.addSubview magicViewsLabel

    self.view.setBackgroundColor UIColor.scrollViewTexturedBackgroundColor

    magicView_1 = MagicView.alloc.initWithFrame [[20,200],[280,400]]
    magicView_1.setBackgroundColor UIColor.colorWithRed(246.0/255, green:246.0/255, blue:246.0/255, alpha:1)
    magicView_1.set_z_index 1
    magicView_1.set_view_title "First"
    self.view.addSubview magicView_1

    magicView_2 = MagicView.alloc.initWithFrame [[15,250],[290,400]]
    magicView_2.setBackgroundColor UIColor.colorWithRed(246.0/255, green:246.0/255, blue:246.0/255, alpha:1)
    magicView_2.set_z_index 2
    magicView_2.set_view_title "Second"
    self.view.addSubview magicView_2

    magicView_3 = MagicView.alloc.initWithFrame [[10,300],[300,400]]
    magicView_3.setBackgroundColor UIColor.colorWithRed(246.0/255, green:246.0/255, blue:246.0/255, alpha:1)
    magicView_3.set_z_index 3
    magicView_3.set_view_title "Third"
    self.view.addSubview magicView_3

    #
    # adding content to magic views
    #

    #don't forget to substract navigation bar height from content view height (-44)
    magic_content_1 = UIView.alloc.initWithFrame magicView_1.frame
    magic_content_1.frame[0][1] -= 44
    magic_content_1.frame[1][1] -= 44
    label_1 = UILabel.alloc.initWithFrame [[10, 5],[magicView_1.frame.size.width,20]]
    label_1.setText "Content View!"
    label_1.sizeToFit

    textField_1 = UITextField.alloc.initWithFrame [[10,25],[magicView_1.frame.size.width,25]]
    textField_1.setBorderStyle UITextBorderStyleRoundedRect

    magic_content_1.addSubview label_1
    magic_content_1.addSubview textField_1
    magicView_1.set_content_view magic_content_1

    layout = UICollectionViewFlowLayout.alloc.init
    #layout.setScrollDirection UICollectionViewScrollDirectionHorizontal
    layout.setItemSize [50, 100]

    collectionFrame = magicView_2.frame
    collectionFrame[0][1] += 44
    collectionFrame[1][1] = 100
    p collectionFrame[1][1]
    p collectionFrame
    collectionView = UICollectionView.alloc.initWithFrame([[0,44],[magicView_2.frame.size.width, 100]], collectionViewLayout:layout)
    collectionView.setDelegate self
    collectionView.setDataSource self
    collectionView.registerClass(UICollectionViewCell, forCellWithReuseIdentifier:"collectionReuseID")
    magicView_2.set_content_view collectionView
    p collectionView.frame

    tableView = UITableView.alloc.initWithFrame magicView_3.frame
    tableView.registerClass(UITableViewCell, forCellReuseIdentifier:"cellReuseID")
    tableView.frame[0][1] -= 44
    p tableView.frame[1][1]
    tableView.frame[1][1] -= 44
    p tableView.frame[1][1]
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