//
//  ViewController.swift
//  scenekit-example
//
//  Created by MacBook on 3/7/20.
//  Copyright © 2020 MacBook. All rights reserved.
//

import UIKit
import SceneKit
import AVKit

class ViewController: UIViewController {

    @IBOutlet weak var sceneView: SCNView!
    var cameraNode = SCNNode()
    var lightNode = SCNNode()
    
    @IBOutlet weak var slider1: UISlider!
    @IBOutlet weak var slider2: UISlider!
    @IBOutlet weak var slider3: UISlider!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBAction func value1Changed(_ sender: UISlider) {
        self.updateValue()
    }
    
    @IBAction func value2Changed(_ sender: UISlider) {
        self.updateValue()
    }
    
    @IBAction func value3Changed(_ sender: UISlider) {
        self.updateValue()
    }
    
    func updateValue() {
        //cameraNode.position = SCNVector3(slider1.value, slider2.value, slider3.value)
        cameraNode.position = SCNVector3(slider1.value, slider2.value, slider3.value)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let scene = SCNScene()
        sceneView.scene = scene
        sceneView.backgroundColor = UIColor.lightGray

        let camera = SCNCamera()
    
        cameraNode = SCNNode()
        cameraNode.camera = camera
        
        let sceneText = SCNText(string: "SCENE KIT EXAMPLE", extrusionDepth: 2.0)
        let textNode = SCNNode(geometry: sceneText)
        textNode.scale = SCNVector3(0.5, 0.5, 0.5)
         
        let ambientLight = SCNLight()
        ambientLight.type = SCNLight.LightType.ambient
        ambientLight.color = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1.0)
        cameraNode.light = ambientLight
        
        let light = SCNLight()
        light.type = SCNLight.LightType.spot
        light.spotInnerAngle = 30.0
        light.spotOuterAngle = 80.0
        light.castsShadow = true
        lightNode.light = light
        lightNode.position = SCNVector3(x: 1.5, y: 1.5, z: 1.5)

        
        let presentationPlane = SCNPlane(width: 100.0, height: 70.0)
        let presentationNode = SCNNode(geometry: presentationPlane)
        presentationNode.eulerAngles = SCNVector3(x: 0, y: 0, z: 0)
        presentationNode.position = SCNVector3(x: 0, y: 0, z: 0)
        
        let cubeGeometry = SCNBox(width: 1.0, height: 1.0, length: 1.0, chamferRadius: 0.0)
        let cubeNode = SCNNode(geometry: cubeGeometry)

        
        cameraNode.position = SCNVector3(x: -3.0, y: 3.0, z: 3.0)
         
        let planeGeometry = SCNPlane(width: 500.0, height: 500.0)
        let planeNode = SCNNode(geometry: planeGeometry)
        planeNode.eulerAngles = SCNVector3(x: GLKMathDegreesToRadians(-90), y: 0, z: 0)
        planeNode.position = SCNVector3(x: 0, y: -0.5, z: 0)

        let redMaterial = SCNMaterial()
        redMaterial.diffuse.contents = UIImage(named: "default")
        
        let customMaterial = SCNMaterial()
        customMaterial.diffuse.contents = UIColor.red

        
        sceneText.materials = [redMaterial]
        cubeGeometry.materials = [redMaterial]
        presentationPlane.materials = [customMaterial]
        
//        sceneText.materials = [redMaterial]
//        cubeGeometry.materials = [redMaterial]
         
        let greenMaterial = SCNMaterial()
        greenMaterial.diffuse.contents = UIColor.green
        planeGeometry.materials = [greenMaterial]

         let constraint = SCNLookAtConstraint(target: planeNode)
         constraint.isGimbalLockEnabled = true
         cameraNode.constraints = [constraint]
         lightNode.constraints = [constraint]
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0.0, y: 0.0))
        path.addLine(to: CGPoint(x: view.frame.size.width/2 - 50.0, y: 0.0))
        path.addArc(withCenter: CGPoint(x: view.frame.size.width/2 - 25.0, y: 25.0),
                    radius: 25.0,
                    startAngle: CGFloat(180.0).toRadians(),
                    endAngle: CGFloat(0.0).toRadians(),
                    clockwise: false)
        path.addLine(to: CGPoint(x: view.frame.size.width/2, y: 0.0))
        path.addLine(to: CGPoint(x: view.frame.size.width - 50.0, y: 0.0))
        path.addCurve(to: CGPoint(x: view.frame.size.width, y: 50.0),
                      controlPoint1: CGPoint(x: view.frame.size.width + 50.0, y: 25.0),
                      controlPoint2: CGPoint(x: view.frame.size.width - 150.0, y: 50.0))
        path.addLine(to: CGPoint(x: view.frame.size.width, y: view.frame.size.height))
        path.addLine(to: CGPoint(x: 0.0, y: view.frame.size.height))
        path.close()
        
        let shapeScn = SCNShape(path: path, extrusionDepth: 2.0)
        let shapeNode = SCNNode(geometry: shapeScn)
        shapeNode.scale = SCNVector3(0.005, 0.005, 0.005)
        shapeScn.materials = [redMaterial]
        
        
        if let system = SCNParticleSystem(named: "MyParticle.sks", inDirectory: nil) {
            cubeNode.addParticleSystem(system)
        }
        
        
        scene.rootNode.addChildNode(lightNode)
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(planeNode)
        scene.rootNode.addChildNode(cubeNode)
        scene.rootNode.addChildNode(textNode)
        scene.rootNode.addChildNode(shapeNode)
        scene.rootNode.addChildNode(presentationNode)
        setupVideo()
        
        if let video = Bundle.main.url(forResource: "video_music", withExtension: "mp4"),
            let videoLowUrl = URL(string:  "https://hclrpgbucketexample.s3.us-east-2.amazonaws.com/video_music.mp4") {
            let player = AVPlayer(url: videoLowUrl)
            customMaterial.diffuse.contents = player
            player.addPeriodicTimeObserver(forInterval: .init(seconds: 0.5, preferredTimescale: 10), queue: .main) { _ in
            customMaterial.diffuse.contents = player
            }
            
            player.play()
            sceneView.play(nil)
        }
    }
    func setupVideo() {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "embededController",
            let navController = segue.destination as? UINavigationController,
            let controller = navController.viewControllers.first as? ElementsTableViewController {
            controller.items = [
                .camera({ [weak self] (x, y, z) in
                    guard let self = self else { return }
                    self.cameraNode.position = SCNVector3(x, y, z)
                }),
                .light({ [weak self] (x, y, z) in
                    guard let self = self else { return }
                    self.lightNode.position = SCNVector3(x, y, z)
                })
            ]
        }
    }

}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Double.pi) / 180.0
    }
}
