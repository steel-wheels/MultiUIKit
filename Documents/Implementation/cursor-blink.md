# How to Display a Rectangular Cursor in NSTextView and Make It Blink

NSTextView does not provide a built‑in option to change the insertion cursor from the default I‑beam shape. 
To create a rectangular (block) cursor and make it blink, you need to customize the drawing behavior by subclassing NSTextView.

## Key Steps

### 1. Subclass `NSTextView`
You override the cursor‑drawing method so you can replace the default cursor with your own block cursor.

### 2. Override `drawInsertionPoint(in:color:turnedOn:)`
This method is responsible for drawing the cursor.  
By overriding it and not calling super, you prevent the default I‑beam from appearing.
Inside this method, you draw a filled rectangle that matches the height of the current glyph.

### 3. Use a Timer for Blinking
Create a repeating timer that toggles a Boolean value (for example, cursorVisible).  
Each time the timer fires, you invalidate the cursor’s rectangle so it redraws.  
When the flag is true, you draw the block cursor; when false, you draw nothing.

### 4. Compute the Cursor Rectangle
Use the layout manager to get the bounding rectangle of the glyph at the insertion point.  
This ensures the cursor height matches the font size.

<pre>
class BlockCursorTextView: NSTextView {

    private var cursorVisible = true
    private var timer: Timer?

    override func viewDidMoveToWindow() {
        super.viewDidMoveToWindow()

        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { [weak self] _ in
            self?.cursorVisible.toggle()
            self?.setNeedsDisplay(self?.insertionRect ?? .zero)
        }
    }

    deinit {
        timer?.invalidate()
    }

    private var insertionRect: NSRect {
        guard let layoutManager = layoutManager,
              let textContainer = textContainer else { return .zero }

        let glyphIndex = layoutManager.glyphIndexForCharacter(at: selectedRange().location)
        return layoutManager.boundingRect(forGlyphRange: NSRange(location: glyphIndex, length: 1),
                                          in: textContainer)
    }

    override func drawInsertionPoint(in rect: NSRect, color: NSColor, turnedOn flag: Bool) {
        guard cursorVisible else { return }

        let blockRect = NSRect(
            x: rect.origin.x,
            y: rect.origin.y,
            width: rect.height * 0.6,
            height: rect.height
        )

        NSColor.labelColor.setFill()
        blockRect.fill()
    }
}
</pre>
