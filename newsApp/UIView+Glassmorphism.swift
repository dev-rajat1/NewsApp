import UIKit

extension UIView {
    
    /// Applies a glassmorphism effect to the view.
    /// Note: The view's background color should be set to `.clear` before calling this.
    func applyGlassEffect(cornerRadius: CGFloat = 16, borderAlpha: CGFloat = 0.2) {
        self.backgroundColor = .clear
        
        // Remove existing visual effect views if any to prevent stacking
        self.subviews.filter { $0 is UIVisualEffectView }.forEach { $0.removeFromSuperview() }
        
        // Create the blur effect (using .systemThinMaterial or .light for light background)
        let blurEffect = UIBlurEffect(style: .systemThinMaterial)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.layer.cornerRadius = cornerRadius
        blurEffectView.layer.masksToBounds = true
        
        // Add subtle white/transparent border for the glass edge highlight
        blurEffectView.layer.borderWidth = 1.0
        blurEffectView.layer.borderColor = UIColor.white.withAlphaComponent(borderAlpha).cgColor
        
        // Insert the blur view at the very bottom of the view hierarchy
        self.insertSubview(blurEffectView, at: 0)
        
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: self.topAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
        
        // Add shadow to the container view itself
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowOpacity = 0.1
        self.layer.shadowRadius = 8
        self.layer.masksToBounds = false
    }
}

extension UIViewController {
    
    /// Adds a modern vibrant gradient background to the view controller
    func applyVibrantGradientBackground() {
        self.view.backgroundColor = .clear // Ensure no white storyboard background blocks it
        
        // Remove existing gradient layers if any
        self.view.layer.sublayers?.filter { $0.name == "VibrantGradient" }.forEach { $0.removeFromSuperlayer() }
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.name = "VibrantGradient"
        
        // A light, soft pastel gradient
        let colorTop = UIColor(red: 224/255.0, green: 242/255.0, blue: 254/255.0, alpha: 1.0).cgColor // Light Blue
        let colorBottom = UIColor(red: 253/255.0, green: 232/255.0, blue: 240/255.0, alpha: 1.0).cgColor // Soft Pink/Peach
        
        gradientLayer.colors = [colorTop, colorBottom]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.frame = self.view.bounds
        
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
}
