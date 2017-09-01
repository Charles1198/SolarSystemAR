//
//  SolarSystemVC.swift
//  SolarSystemWithAR
//
//  Created by charles on 2017/9/1.
//  Copyright © 2017年 bqteam. All rights reserved.
//

import UIKit
import SceneKit
import ARKit

class SolarSystemVC: UIViewController, ARSCNViewDelegate {
    
    @IBOutlet var sceneViews: ARSCNView!
    
    var scene = SCNScene()
    
    var sun = SCNNode()
    var mercury = SCNNode()
    var venus = SCNNode()
    var earth = SCNNode()
    var mars = SCNNode()
    var jupiter = SCNNode()
    var saturn = SCNNode()
    var uranus = SCNNode()
    var neptune = SCNNode()
    
    var mercuryRotationNode = SCNNode()
    var venusRotationNode = SCNNode()
    var earthRotationNode = SCNNode()
    var marsRotationNode = SCNNode()
    var jupiterRotationNode = SCNNode()
    var saturnRotationNode = SCNNode()
    var uranusRotationNode = SCNNode()
    var neptuneRotationNode = SCNNode()
    
    var moon = SCNNode()
    
    //星球半径
    let radiusSun = 2.5        //太阳
    let radiusMercury = 0.2    //水星
    let radiusVenus = 0.4      //金星
    let radiusEarth = 0.5      //地球
    let radiusMars = 0.3       //火星
    let radiusJupiter = 1.5    //木星
    let radiusSaturn = 1.2     //土星
    let radiusUranus = 0.9     //天王星
    let radiusNeptune = 0.8    //海王星
    
    let radiusMoon = 0.1        //月球
    
    //轨道半径
    let trackRadiusSun = 0
    let trackRadiusMercury = 4.0
    let trackRadiusVenus = 6.0
    let trackRadiusEarth = 8.0
    let trackRadiusMars = 10.0
    let trackRadiusJupiter = 14.0
    let trackRadiusSaturn = 17.8
    let trackRadiusUranus = 22.5
    let trackRadiusNeptune = 29.4
    
    let trackRadiusMoon = 1.0
    
    //公转周期
    let rotationDurationMercury = 20.0
    let rotationDurationVenus = 30.0
    let rotationDurationEarth = 45.0
    let rotationDurationMars = 50.0
    let rotationDurationJupiter = 70.0
    let rotationDurationSaturn = 90.0
    let rotationDurationUranus = 120.0
    let rotationDurationNeptune = 150.0
    
    //自转周期
    let rotationDurationSelfSun = 10.0
    let rotationDurationSelfMercury = 2.0
    let rotationDurationSelfVenus = 3.0
    let rotationDurationSelfEarth = 5.0
    let rotationDurationSelfMars = 15.0
    let rotationDurationSelfJupiter = 12.0
    let rotationDurationSelfSaturn = 8.0
    let rotationDurationSelfUranus = 7.0
    let rotationDurationSelfNeptune = 6.0
    
    let rotationDurationSelfMoon = 6.0
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Create a session configuration
        let configuration = ARWorldTrackingConfiguration()
        
        // Run the view's session
        sceneViews.session.run(configuration)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Pause the view's session
        sceneViews.session.pause()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
          

        //获取SCNView
        let scnView = self.view as! SCNView
        //将SCNView的场景设置为我的场景
        scnView.scene = scene
        
        // create and add a camera to the scene
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        scene.rootNode.addChildNode(cameraNode)
        
        // place the camera
        cameraNode.position = SCNVector3(x: 0, y: 0, z: 80)
        
        // create and add a light to the scene
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light!.type = .ambient
        lightNode.position = SCNVector3(x: 0, y: 10, z: 10)
        scene.rootNode.addChildNode(lightNode)
        
        // create and add an ambient light to the scene
        let ambientLightNode = SCNNode()
        ambientLightNode.light = SCNLight()
        ambientLightNode.light!.type = .ambient
        ambientLightNode.light!.color = UIColor.white
        scene.rootNode.addChildNode(ambientLightNode)
        
        //创建太阳
        sun = creatPlant(name: "sun", radius: radiusSun, pX: 0, pY: 0, pZ: 0, hasTrack: false, rotationSelfDuration: rotationDurationSelfSun)
        scene.rootNode.addChildNode(sun)
        
        //创建水星
        mercury = creatPlant(name: "mercury", radius: radiusMercury, pX: trackRadiusMercury, pY: 0, pZ: 0, hasTrack: true, rotationSelfDuration: rotationDurationSelfMercury)
        mercuryRotationNode = createPlantRotationCenter(name: "mercury", rotationDuration: rotationDurationMercury)
        mercuryRotationNode.addChildNode(mercury)
        scene.rootNode.addChildNode(mercuryRotationNode)
        
        //创建金星
        venus = creatPlant(name: "venus", radius: radiusVenus, pX: trackRadiusVenus, pY: 0, pZ: 0, hasTrack: true, rotationSelfDuration: rotationDurationSelfVenus)
        venusRotationNode = createPlantRotationCenter(name: "venus", rotationDuration: rotationDurationVenus)
        venusRotationNode.addChildNode(venus)
        scene.rootNode.addChildNode(venusRotationNode)
        
        //创建地球
        earth = creatPlant(name: "earth", radius: radiusEarth, pX: trackRadiusEarth, pY: 0, pZ: 0, hasTrack: true, rotationSelfDuration: rotationDurationSelfEarth)
        earthRotationNode = createPlantRotationCenter(name: "earth", rotationDuration: rotationDurationEarth)
        earthRotationNode.addChildNode(earth)
        scene.rootNode.addChildNode(earthRotationNode)
        
        //创建火星
        mars = creatPlant(name: "mars", radius: radiusMars, pX: trackRadiusMars, pY: 0, pZ: 0, hasTrack: true, rotationSelfDuration: rotationDurationSelfMars)
        marsRotationNode = createPlantRotationCenter(name: "mars", rotationDuration: rotationDurationMars)
        marsRotationNode.addChildNode(mars)
        scene.rootNode.addChildNode(marsRotationNode)
        
        //创建木星
        jupiter = creatPlant(name: "jupiter", radius: radiusJupiter, pX: trackRadiusJupiter, pY: 0, pZ: 0, hasTrack: true,  rotationSelfDuration: rotationDurationSelfJupiter)
        jupiterRotationNode = createPlantRotationCenter(name: "jupiter", rotationDuration: rotationDurationJupiter)
        jupiterRotationNode.addChildNode(jupiter)
        scene.rootNode.addChildNode(jupiterRotationNode)
        
        //创建土星
        saturn = creatPlant(name: "saturn", radius: radiusSaturn, pX: trackRadiusSaturn, pY: 0, pZ: 0, hasTrack: true, rotationSelfDuration: rotationDurationSelfSaturn)
        saturnRotationNode = createPlantRotationCenter(name: "saturn", rotationDuration: rotationDurationSaturn)
        saturnRotationNode.addChildNode(saturn)
        scene.rootNode.addChildNode(saturnRotationNode)
        
        //创建天王星
        uranus = creatPlant(name: "uranus", radius: radiusUranus, pX: trackRadiusUranus, pY: 0, pZ: 0, hasTrack: true, rotationSelfDuration: rotationDurationSelfUranus)
        uranusRotationNode = createPlantRotationCenter(name: "uranus", rotationDuration: rotationDurationUranus)
        uranusRotationNode.addChildNode(uranus)
        scene.rootNode.addChildNode(uranusRotationNode)
        
        //创建海王星
        neptune = creatPlant(name: "neptune", radius: radiusNeptune, pX: trackRadiusNeptune, pY: 0, pZ: 0, hasTrack: true,  rotationSelfDuration: rotationDurationSelfNeptune)
        neptuneRotationNode = createPlantRotationCenter(name: "neptune", rotationDuration: rotationDurationNeptune)
        neptuneRotationNode.addChildNode(neptune)
        scene.rootNode.addChildNode(neptuneRotationNode)
        
        //创建月亮
        moon = creatPlant(name: "moon", radius: radiusMoon, pX: trackRadiusMoon, pY: 0, pZ: 0, hasTrack: false,  rotationSelfDuration: 100000)
        addTrack(name: "moon", radius: trackRadiusMoon, onPlant: earth)
        earth.addChildNode(moon)
    }
    
    /// 创建一个星球
    ///
    /// - Parameters:
    ///   - name: 星球名
    ///   - radius: 半径
    ///   - pX: 位置X
    ///   - pY: 位置Y
    ///   - pZ: 位置Z
    ///   - hasTrack: 是否画轨道
    ///   - rotationSelfDuration: 自转周期
    /// - Returns: 目标星球
    func creatPlant(name: String, radius: Double, pX: Double, pY: Double, pZ: Double, hasTrack: Bool, rotationSelfDuration:Double) -> SCNNode {
        let geometry = SCNSphere.init(radius: CGFloat(radius / 20))
        geometry.materials.first?.diffuse.contents = "art.scnassets/image/" + name + ".jpg"
        //SCNSphere是SCNGeomery的一个子类，通过这个类可以创建更多的形状
        let node = SCNNode(geometry: geometry)
        node.position = SCNVector3(pX / 20, pY, pZ)//节点的位置
        node.name = name
        
        let animtion = CABasicAnimation.init(keyPath: "rotation")
        animtion.duration = rotationSelfDuration
        animtion.toValue = NSValue.init(scnVector4: SCNVector4.init(0, 1, 0, Double.pi * 2))
        animtion.repeatCount = Float.greatestFiniteMagnitude
        node.addAnimation(animtion, forKey: "animtion_" + name + "RS")
        
        if hasTrack {
            //轨道半径
            let tractRadius = sqrt(pX * pX + pY * pY)
            addTrack(name: name, radius: tractRadius, onPlant: sun)
        }
        
        return node
    }
    
    
    /// 为星球创造一个公转中心
    ///
    /// - Parameters:
    ///   - name: 星球名
    ///   - rotationDuration: 公转周期
    /// - Returns: 目标中心
    func createPlantRotationCenter(name: String, rotationDuration:Double) -> SCNNode {
        let geometry = SCNSphere.init(radius: 0.1)
        geometry.materials.first?.diffuse.contents = UIColor.white
        let node = SCNNode(geometry: geometry)
        node.name = name + "R"
        
        let animtion = CABasicAnimation.init(keyPath: "rotation")
        animtion.duration = rotationDuration
        animtion.toValue = NSValue.init(scnVector4: SCNVector4.init(0, 1, 0, Double.pi * 2))
        animtion.repeatCount = Float.greatestFiniteMagnitude
        node.addAnimation(animtion, forKey: "animtion_" + name + "R")
        
        return node
    }
    
    /// 添加一个轨道
    ///
    /// - Parameters:
    ///   - name: 轨道名
    ///   - radius: 轨道半径
    ///   - onPlant: 轨道中心星球
    func addTrack(name: String, radius: Double, onPlant: SCNNode) {
        let geometry = SCNTorus.init(ringRadius: CGFloat(radius / 20), pipeRadius: 0.001)
        geometry.materials.first?.diffuse.contents = UIColor.init(white: 1, alpha: 0.4)
        let node = SCNNode(geometry: geometry)
        node.name = name + "T"
        onPlant.addChildNode(node)
    }

   
}
