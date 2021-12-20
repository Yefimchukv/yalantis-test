# Hello, everyone! <img src="https://raw.githubusercontent.com/MartinHeinz/MartinHeinz/master/wave.gif" width="30px">

## This is my technical task for Yalantis iOS School :)

### I would also extend this app during my studying process

#### Here's an example of predictions animation:

https://user-images.githubusercontent.com/58046252/144745740-84287750-cf5a-47e0-b82b-e98bd63ffb75.mp4

## App tech-stack
- MVVVM with active model architecture
- Local/Network answer response 
- Core Data data storage
- Used NavigationNode & Coordinator Patterns
- Used haptics & CoreMotion to interact with user
- Some reactive implementations with Rx

### Shaking interaction:
```
motionManager.startGyroUpdates(to: .main) { data, _ in
    guard let data = data else { return }
    
    UIView.animate(withDuration: 0.1) {
        
        self.titleView.layer.position.x -= data.rotationRate.z / 2
        self.titleView.layer.position.y -= data.rotationRate.x / 2
    } completion: { _ in
        UIView.animate(withDuration: 0.1) {
            
            self.titleView.layer.position.x += data.rotationRate.z / 2
            self.titleView.layer.position.y += data.rotationRate.x / 2
        }
    }
}

Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
    
    if self.isShaking {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    } else {
        timer.invalidate()
    }
}
```

### Loading animation:

```        
UIView.animate(withDuration: 1, delay: 0, options: []) {
        self.titleBallImage.layer.position.y -= 32
    } completion: { _ in
        UIView.animate(withDuration: 1) {
            self.titleBallImage.transform = CGAffineTransform(rotationAngle: .pi)
            self.titleBallImage.transform = CGAffineTransform(rotationAngle: .pi * 2)
        } completion: {  _ in
            UIView.animate(withDuration: 1, delay: 0, options: []) {
                
                self.titleBallImage.layer.position.y += 32
            } completion: { _ in
                
                if self.isAnswerLoaded {
                    self.presentAnswer(title: self.currentAnswer?.answerTitle, message: self.currentAnswer?.answerSubtitle)
                } else {
                    self.loadWithAnimationsIfNeeded()
                }
            }
        }
    }
```
