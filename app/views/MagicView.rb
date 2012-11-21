class MagicView < UIView
  def initWithFrame(frame)
    super

    @spacer = 50

    @first_position = frame
    self.clipsToBounds = true

    #setting up shadows, borders, etc
    self.layer.shadowColor = UIColor.blackColor.CGColor
    self.layer.shadowOffset = [10,10]
    self.layer.shadowOpacity = 0.5
    self.layer.shadowRadius = 10.0

    self.layer.borderColor = UIColor.blackColor.CGColor
    self.layer.borderWidth = 1

    self.layer.cornerRadius = 3

    #setting up fake navigation bar view
    @navigationBarView = UIView.alloc.initWithFrame [[0,0],[self.bounds.size.width,44]]
    @navigationBarView.setBackgroundColor UIColor.colorWithPatternImage UIImage.imageNamed 'navigation_bar_texture.png'
    self.addSubview @navigationBarView

    #setting up nav bar and view title
    @viewTitle = UILabel.alloc.initWithFrame [[0,0],[self.frame.size.width, 20]]
    @viewTitle.setCenter [self.frame.size.width * 0.5, @navigationBarView.frame.size.height * 0.5]
    @viewTitle.setTextAlignment UITextAlignmentCenter
    @viewTitle.setFont UIFont.fontWithName("Helvetica", size:20)
    @viewTitle.setTextColor UIColor.whiteColor
    @viewTitle.setBackgroundColor UIColor.clearColor
    @navigationBarView.addSubview @viewTitle

    #setting up gestures
    panGesture = UIPanGestureRecognizer.alloc.initWithTarget(self, action:'handlePanGesture:')
    panGesture.minimumNumberOfTouches = 1
    @navigationBarView.addGestureRecognizer panGesture

    @mainView = false

    self
  end

  def springBack
    springBackAnimation = lambda do 
      self.setFrame @first_position
    end

    UIView.animateWithDuration(0.2, animations:springBackAnimation)

    otherMagicViews = []
    superview.subviews.each do |view|
      if view.is_a? MagicView
        otherMagicViews << view if view.z_index > @z_index
      end
    end

    otherMagicViews.each do |view|
      view.springBack
    end
  end

  def makeMainView
    @mainView = true

    growUpAnimation = lambda do
      self.setFrame UIScreen.mainScreen.bounds
      @viewTitle.setCenter [self.frame.size.width * 0.5, @viewTitle.center.y]
      @navigationBarView.setFrame [[0,0],[self.frame.size.width, 44]]
    end

    completionAnimation = lambda do |completion|
      hideOtherViews
    end

    UIView.animateWithDuration(0.2, animations:growUpAnimation, completion:completionAnimation)
  end

  def handlePanGesture(gesture)
    #get new Y position and changing frame's position
    point_y = gesture.translationInView(self.superview.superview).y
    return if point_y < 0 && @mainView

    new_frame = self.frame
    new_frame[0][1] += point_y

    if self.frame[1][0] > @first_position[1][0]
      new_frame[1][0] -= 2
      new_frame[0][0] += 1
      @viewTitle.setCenter [new_frame[1][0] * 0.5, @viewTitle.center.y]
      @navigationBarView.setFrame [[0,0],[new_frame[1][0],44]]
    end

    self.setFrame new_frame

    if point_y > 0
      if @mainView
        #@navigationBarView.setFrame [[0,0],[first_position[1][1],44]]
        @mainView = false
      end
      
      push_other_views_to point_y
    else
      push_other_views_to point_y
    end

    gesture.setTranslation([0,0], inView:self.superview.superview)

    if  gesture.state == UIGestureRecognizerStateCancelled ||
        gesture.state == UIGestureRecognizerStateEnded ||
        gesture.state == UIGestureRecognizerStateFailed
      
      screen_height = UIScreen.mainScreen.bounds.size.height
      if self.frame[0][1] < screen_height / 3
        #we ready to make this view main view
        makeMainView
      else 
        springBack
      end
    end
  end

  def push_other_views_to(point_y)
    otherMagicViews = []
    superview.subviews.each do |view|
      if view.is_a? MagicView
        otherMagicViews << view if view.z_index > @z_index
      end
    end

    otherMagicViews.each do |view|
      new_frame = view.frame
      new_frame[0][1] += point_y
      diff = view.frame[0][1] - self.frame[0][1]
      if point_y > 0
        view.setFrame new_frame if new_frame[0][1] >= view.first_position[0][1] && diff <= @spacer * (view.z_index - @z_index)
      else 
        view.setFrame new_frame if new_frame[0][1] >= view.first_position[0][1] && point_y < 0
      end
    end
  end

  def hideOtherViews
    otherMagicViews = []
    superview.subviews.each do |view|
      if view.is_a? MagicView
        otherMagicViews << view if view.z_index > @z_index
      end
    end

    otherMagicViews.each do |view|
      hideAnimation = lambda do
        new_frame = view.frame
        new_frame[0][1] = UIScreen.mainScreen.bounds.size.height + (@spacer * view.z_index - @z_index)
        view.setFrame new_frame
      end
      UIView.animateWithDuration(0.2, animations:hideAnimation)
    end    
  end

  #
  # getters, setters, and other trash
  #

  def set_view_title(title)
    @viewTitle.setText title
  end

  def set_z_index(z_index)
    @z_index = z_index
  end

  def z_index
    @z_index
  end

  def first_position
    @first_position
  end

  def set_content_view(newContentView)
    newContentView.setFrame [[0,@navigationBarView.frame.size.height],[self.frame.size.width,self.frame.size.height - @navigationBarView.frame.size.height]]
    @contentView = newContentView
    self.addSubview @contentView
  end
end