//
//  DrawingCanvasView.swift
//  DoodleBug
//
//  Created by Michael Testut on 7/26/25.
//


import SwiftUI
import PencilKit // << 1. Import PencilKit

// 2. We need a way for SwiftUI to talk to our UIKit canvas.
// This coordinator class will act as a messenger.
class Coordinator: NSObject, PKCanvasViewDelegate {
    var parent: DrawingCanvasView

    init(_ parent: DrawingCanvasView) {
        self.parent = parent
    }
}


// 3. This is the SwiftUI "wrapper" for the UIKit PKCanvasView.
// It's a bridge between the two worlds.
struct DrawingCanvasView: UIViewRepresentable {
    
    // This allows us to pass a binding to the PKCanvasView from our main view
    @Binding var drawing: PKDrawing
    
    let selectedColor: Color
    
    // We create a coordinator to handle events
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, PKCanvasViewDelegate {
            var parent: DrawingCanvasView

            init(_ parent: DrawingCanvasView) {
                self.parent = parent
            }

            // This function is called by PencilKit whenever the drawing changes.
            func canvasViewDrawingDidChange(_ canvasView: PKCanvasView) {
                // We update the binding with the new drawing from the canvas.
                DispatchQueue.main.async {
                    self.parent.drawing = canvasView.drawing
                    }            }
        }
    
    // This function creates the actual UIKit view (our canvas)
    func makeUIView(context: Context) -> PKCanvasView {
        let canvas = PKCanvasView()
        canvas.drawingPolicy = .anyInput // Allows drawing with finger and Apple Pencil
        canvas.tool = PKInkingTool(.pen, color: .black, width: 15) // Set a default pen
        canvas.delegate = context.coordinator // Set the delegate
        return canvas
    }
    
    // This function is called if the SwiftUI state changes, allowing us to update the UIKit view.
    // We don't need it right now, but it's required.
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.drawing = drawing
        uiView.tool = PKInkingTool(.pen, color: UIColor(selectedColor), width: 15)
    }
}
