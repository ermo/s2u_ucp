// NFS Ford Mustang Boss  high-detail Car parameter file

[GENERAL]
Rules=0                         // what rules to apply to garage setups (0=none, 1=stock car)
GarageDisplayFlags=7            // how settings are displayed in garage (add): 1=rear wing, 2=radiator, 4=more gear info
FeelerFlags=0                 // how collision feelers are generated (add): 1=box influence 2=reduce wall-jumping 4=allow adjustment hack 8=top directions
Mass=1550.0                      // all mass except fuel  (1395kg car + 80kg driver weight)
Inertia=(2380.0,2500.0,450.0)    // all inertia except fuel
FuelTankPos=(0.0, 0.200, 0.200)  // location of tank affects center of gravity (very close and even slightly ahead of CG in F1)
FuelTankMotion=(560.0,0.7)      // simple model of fuel movement in tank (spring rate per kg, critical damping ratio)
Notes=""
Symmetric=1
CGHeight=0.300                  // height of body mass (excluding fuel) above reference plane
CGRightRange=(0.50, 0.000, 0)  // fraction of weight on left tires
CGRightSetting=0
CGRearRange=(0.43, 0.005, 0)
CGRearSetting=0
GraphicalOffset=(0.0, 0.0, 0.0) // does not affect physics!
CollisionOffset=(0.0, 0.02, 0.0) // Moves collision mesh independently of G'offset
Undertray00=(0.90,  0.02, -1.895)  // offset from center of car, and between axles// LF (Left front corner of splitter) (forward is negative, right is negative)
Undertray01=(-0.90, 0.02, -1.895)  // offset from center of car, and between axles// RF (Right front corner of splitter)
Undertray02=(0.90,  0.02, 0.800)  // offset from center of car, and between axles // LR (Left rear corner of rocker)
Undertray03=(-0.90, 0.02, 0.800)  // offset from center of car, and between axles // RR (Right rear corner of rocker)
UndertrayParams=(262500.0,11600.0, 0.0) // undertray spring rate, damper rate, and coefficient of friction(770000.0,35000.0, 4.0)
FrontTireCompoundSetting=0         // Front compound index within brand
RearTireCompoundSetting=0          // Rear compound index within brand
FuelRange=(1.0, 1.0, 100)
FuelSetting=49
NumPitstopsRange=(0, 1, 4)
NumPitstopsSetting=3
Pitstop1Range=(1.0, 1.0, 100)
Pitstop1Setting=64
Pitstop2Range=(1.0, 1.0, 100)
Pitstop2Setting=64
Pitstop3Range=(1.0, 1.0, 100)
Pitstop3Setting=64
AIMinPassesPerTick=2            // minimum passes per tick (can use more accurate spring/damper/torque values, but takes more CPU)
AIRotationThreshold=0.12        // rotation threshold (rads/sec) to temporarily increment passes per tick
AIEvenSuspension=0.0            // averages out spring and damper rates to improve stability (0.0 - 1.0)
AISpringRate=1.0               // spring rate adjustment for AI physics (improves stability)
AIDamperSlow=1.2                // contribution of average slow damper into simple AI damper
AIDamperFast=0.4                // contribution of average fast damper into simple AI damper
AIDownforceZArm=0.150           // hard-coded center-of-pressure offset from vehicle CG
AIDownforceBias=0.0             // bias between setup and hard-coded value (0.0-1.0)
AITorqueStab=(1.25, 1.25, 1.25)   // torque adjustment to keep AI stable

[FRONTWING]
FWRange=(0.0, 1.0, 0)          // front wing range
FWSetting=0                    // front wing setting
FWMaxHeight=(0.10)              // maximum height to take account of for downforce
FWDragParams=(0.07, 0.003, 0.00)        // base drag and 1st and 2nd order with setting
FWLiftParams=(-0.000, -0.028, 0.00)  // base lift and 1st and 2nd order with setting
FWLiftHeight=(0.335)            // effect of current height on lift coefficient
FWLiftSideways=(0.0)            // dropoff in downforce with yaw (0.0 = none, 1.0 = max)
FWLeft=(-0.30, 0.0, 0.0)        // aero forces from moving left
FWRight=(0.30, 0.0, 0.0)        // aero forces from moving right
FWUp=(0.0, -0.5, -0.001)       // aero forces from moving up
FWDown=(0.0, 0.25, 0.001)       // aero forces from moving down
FWAft=(0.0, 0.02, -0.02)        // aero forces from moving rearwards
FWFore=(0.0, 0.0, 0.0)          // aero forces from moving forwards (recomputed from settings)
FWRot=(0.05, 0.025, 0.075)        // aero torque from rotating
FWCenter=(0.00, 0.00, -0.60)    // center of front wing forces (offset from center of front axle in ref plane)

[REARWING]
RWRange=(0.0, 1.0, 0)          // rear wing range
RWSetting=0                   // rear wing setting
RWDragParams=(0.08, 0.004, 0.00)        // base drag and 1st and 2nd order with setting
RWLiftParams=(-0.000, -0.028, 0.00)  // base lift and 1st and 2nd order with setting
RWLiftSideways=(0.0)            // dropoff in downforce with yaw (0.0 = none, 1.0 = max)
RWPeakYaw=(0.0, 0.00)           // angle of peak, multiplier at peak
RWLeft=(-0.9, 0.0, 0.0)        // aero forces from moving left
RWRight=(0.9, 0.0, 0.0)        // aero forces from moving right
RWUp=(0.0, -0.50, -0.002)       // aero forces from moving up
RWDown=(0.0, 0.25, 0.002)       // aero forces from moving down
RWAft=(0.0, 0.03, -0.4)        // aero forces from moving rearwards
RWFore=(0.0, 0.0, 0.0)          // aero forces from moving forwards (recomputed from settings)
RWRot=(0.08, 0.05, 0.11)        // aero torque from rotating
RWCenter=(0.00, 0.60, 0.80)     // center of rear wing forces (offset from center of rear axle at ref plane)

[BODYAERO]
BodyDragBase=(0.500)            // base drag
BodyDragHeightAvg=(0.22)       // drag increase with average ride height
BodyDragHeightDiff=(0.47)       // drag increase with front/rear ride height difference
BodyMaxHeight=(0.20)            // maximum ride height that affects drag/lift
BodyLeft=(-0.8, 0.0, 0.0)       // aero forces from moving left
BodyRight=(0.8, 0.0, 0.0)       // aero forces from moving right
BodyUp=(0.0, -1.0, 0.0)         // aero forces from moving up
BodyDown=(0.0, 0.6, 0.0)        // aero forces from moving down
BodyAft=(0.0, 0.20, -0.8)      // aero forces from moving rearwards
BodyFore=(0.0, -0.160, 0.435)  // aero forces from moving forwards (lift value important!)
BodyRot=(5.73, 4.3, 2.87)         // aero torque from rotating 
BodyCenter=(0.0, 0.50, -1.85)   // center of body aero forces (offset from center of rear axle at ref plane)
RadiatorRange=(0.0, 1.0, 4)      // radiator range
RadiatorSetting=3               // radiator setting
RadiatorDrag=(0.005)            // effect of radiator setting on drag
RadiatorLift=(0.003)            // effect of radiator setting on lift
BrakeDuctRange=(0.0, 1.0, 5)    // brake duct range
BrakeDuctSetting=1              // brake duct setting
BrakeDuctDrag=(0.006)           // effect of brake duct setting on drag
BrakeDuctLift=(0.00825)           // effect of brake duct setting on lift

[DIFFUSER]
DiffuserBase=(-0.000, -0.50, 5.0) // base lift and 1st/2nd order with rear ride height
DiffuserFrontHeight=(0.000)         // 1st order with front ride height
DiffuserRake=(0.005, -0.0, 0.0)        // Optimum rake (rear - front ride height), 1st order with current difference from opt, 2nd order
DiffuserLimits=(0.010, 0.100, 0.055)    // Min ride height before stalling begins (0.0 to disable), max rear ride height for computations, max rake difference for computations
DiffuserStall=(0.0, 1.0)  // function to compute stall ride height (0.0=minimum, 1.0=average), downforce lost when bottoming out (0.0=none,1.0=complete stall)
DiffuserSideways=(0.0)              // dropoff with yaw (0.0 = none, 1.0 = max)
DiffuserCenter=(0.0, 0.00, -1.30)  // center of diffuser forces (offset from center of rear axle at ref plane)

[SUSPENSION]
ApplySlowToFastDampers=0         // whether to apply slow damper settings to fast damper settings
CorrectedInnerSuspHeight=-1        // instead of moving inner susp height relative with ride height, use this offset (set to -1 for original behavior)
AdjustSuspRates=1                // adjust suspension rates due to motion ratio ( 0=enable, 1=disable)
AlignWheels=1                    // correct for minor graphical offsets
SpringBasedAntiSway=1            // 0=diameter-based, 1=spring-based
FrontAntiSwayBase=0.0
FrontAntiSwayRange=(10000.0, 10000.0, 10)
FrontAntiSwaySetting=2
FrontAntiSwayRate=(1.36e11, 4.0) // not applicable with spring-based antisway
AllowNoAntiSway=1                // Whether first setting gets overridden to mean no antisway bar
RearAntiSwayBase=0.0
RearAntiSwayRange=(5000.0, 5000.0, 10)
RearAntiSwaySetting=2
RearAntiSwayRate=(1.36e11, 4.0)  // not applicable with spring-based antisway
FrontToeInRange=(2.0, -0.1, 41)
FrontToeInSetting=21
RearToeInRange=(2.0, -0.1, 41)
RearToeInSetting=19
LeftCasterRange=(0.0, 0.1, 100)          // front-left caster
LeftCastersetting=20
RightCasterRange=(0.0, 0.1, 100)         // front-right caster
RightCastersetting=20

[CONTROLS]
DriftDriveTorqueMultiplier=(1.2,1.2,1.2,1.2)
DriftGrip=(1.0,1.0,1.0,1.0)
DriftSteerFilterSpeedOffset=8.0
DriftIdealLineHelp=(1,1,0,0)
ThrottleControl=(2,2,1,0)
AntilockBrakes=(2,2,1,1)
SteeringFFBMult=1.0
UpshiftAlgorithm=(0.98,0.0) //  percentage of the rev limit to upshift at.  If the 2nd value is non-zero, then we will use it as the exact RPM to upshift at.
DownshiftAlgorithm=(0.80,0.75,0.75) // percentage of "optimum" downshift point in high gears, percentage of "optimum" downshift point in low gears, oval adjustment.
SteerLockRange=(0.0, 1.0, 50)
SteerLockSetting=27
DriftSteerLockSetting=47
RearBrakeRange=(0.200, 0.005, 121)
RearBrakeSetting=50
BrakePressureRange=(0.80, 0.01, 20)
BrakePressureSetting=15
HandbrakePressRange=(0.00, 0.05, 21) // 
HandbrakePressSetting=20
AutoUpshiftGripThresh=0.0          // auto upshift waits until all driven wheels have this much grip (reasonable range: 0.4-0.9)
AutoDownshiftGripThresh=0.0        // auto downshift waits until all driven wheels have this much grip (reasonable range: 0.4-0.9)
TractionControlGrip=(1.00, 0.20)    // average driven wheel grip multiplied by 1st number, then added to 2nd
TractionControlLevel=(0.30, 0.90)   // effect of grip on throttle for low TC and high TC
ABS4Wheel=1                         // 0 = old-style single brake pulse, 1 = more effective 4-wheel ABS
ABSGrip=(1.00, 0.20)                // grip multiplied by 1st number and added to 2nd
ABSLevel=(0.20, 0.40)               // effect of grip on brakes for low ABS and high ABS


[ENGINE]
SpeedLimiter=1                      // Whether a pitlane speed limiter is available

[DRIVELINE]
DriftDiffSpool=1
AdjustableFinalGearsMinimumLevel=1
AdjustableGearsMinimumLevel=3
AdjustableGearsRange=2
AdjustableGearsFinalRange=4
ClutchEngageRate=0.8          //Auto clutch gradual engagement rate from neutral to 1st gear.
ClutchInertia=0.0148
ClutchTorque=600.0
ClutchWear=0.0
ClutchFriction=15.000
BaulkTorque=650.0
SemiAutomatic=0                     // whether throttle and clutch are operated automatically
UpshiftDelay=0.30                  // delay in selecting higher gear (low for semi-automatic, higher for manual)
UpshiftClutchTime=0.30             // time to ease auto-clutch in AFTER upshift (0.0 for F1 cars)
DownshiftDelay=0.50               // delay in selecting lower gear (low for semi-automatic, higher for manual)
DownshiftClutchTime=0.50           // time to ease auto-clutch in AFTER downshift (used to be SemiAutoClutchTime, note that the shift will complete significantly before the clutch is fully engaged)
DownshiftBlipThrottle=0.70          // amount of throttle used to blip if controlled by game (instead of player)
WheelDrive=REAR                     // which wheels are driven: REAR, FOUR (even torque split), or FRONT
FinalDriveSetting=33                 // indexed into GearFile list
ReverseSetting=0
ForwardGears=4
Gear1Setting=6
Gear2Setting=27
Gear3Setting=47
Gear4Setting=56
Gear5Setting=55
Gear6Setting=57
DiffPumpTorque=00.0                // at 100% pump diff setting, the torque redirected per wheelspeed difference in radians/sec (roughly 1.2kph)
DiffPumpRange=(0.00, 0.00, 0)
DiffPumpSetting=0
DiffPowerRange=(0.0,0.05,20)        // fraction of power-side input torque transferred through diff
DiffPowerSetting=6                // (not implemented for four-wheel drive)
DiffCoastRange=(0.0,0.05,20)        // fraction of coast-side input torque transferred through diff
DiffCoastSetting=10                 // (not implemented for four-wheel drive)
DiffPreloadRange=(0.0, 10.0, 20)     // preload torque that must be overcome to have wheelspeed difference
DiffPreloadSetting=8                // (not implemented for four-wheel drive)

[FRONTLEFT]
BumpTravel=-0.000                   // travel to bumpstop with zero packers and zero ride height
ReboundTravel=-0.190                // these two numbers assume front ride height is 30cm to 90cm with 10cm leeway
BumpStopSpring=60000.0             // initial spring rate of bumpstop
BumpStopRisingSpring=1.25e9         // rising spring rate of bumpstop (multiplied by deflection squared)
BumpStopDamper=2500.0               // initial damping rate of bumpstop
BumpStopRisingDamper=2.19e7         // rising damper rate of bumpstop (multiplied by deflection squared)
BumpStage2=0.090                    // speed where damper bump moves from slow to fast
ReboundStage2=-0.090                // speed where damper rebound moves from slow to fast
FrictionTorque=9.50                 // Newton-meters of friction between spindle and wheel
SpinInertia=1.622                   // inertia in pitch direction including any axle
CGOffsetX=0.000                     // x-offset from graphical center to physical center (NOT IMPLEMENTED)
PushrodSpindle=(-0.150, -0.150, 0.000) // relative to spindle
PushrodBody=(-0.350, 0.320, 0.000)   // spring/damper connection to body (relative to wheel center)
CamberRange=(-5.0, 0.1, 100)
CamberSetting=35
PressureRange=(0.0, 1.0, 286)
PressureSetting=240
PackerRange=(0.000, 0.001, 30)
PackerSetting=0
SpringMult=1.0                 // take into account suspension motion if spring is not attached to spindle (affects physics but not garage display)
SpringRange=(45000.0, 7500.0, 6)
SpringSetting=0
RideHeightRange=(0.170, -0.0075, 10)
RideHeightSetting=0
DamperMult=1.0                    // take into account suspension motion if damper is not attached to spindle (affects physics but not garage display)
SlowBumpRange=(4000.0, 300.0, 11)
SlowBumpSetting=0
FastBumpRange=(2000.0, 200.0, 11)
FastBumpSetting=0
SlowReboundRange=(8000.0, 300.0, 16)
SlowReboundSetting=0
FastReboundRange=(4000.0, 300.0, 16)
FastReboundSetting=0
BrakeDiscRange=(0.035, 0.000, 0)    // disc thickness
BrakeDiscSetting=0
BrakePadRange=(0, 1, 5)             // pad type (not implemented)
BrakePadSetting=2
BrakeDiscInertia=0.001              // inertia per meter of thickness
BrakeOptimumTemp=450.0              // optimum brake temperature in Celsius
BrakeFadeRange=450.0               // temperature outside of optimum that brake grip drops to half (too hot or too cold)
BrakeWearRate=1.215e-011             // meters of wear per second at optimum temperature
BrakeFailure=(1.33e-002,7.20e-004)  // average and variation in disc thickness at failure
BrakeTorque=2600.0                  // maximum brake torque at zero wear and optimum temp
BrakeHeating=0.00055                 // heat added linearly with brake torque
BrakeCooling=(1.910e-002,0.667e-004)  // minimum brake cooling rate (static and per unit velocity)
BrakeDuctCooling=2.000e-004         // brake cooling rate per brake duct setting

[FRONTRIGHT]
BumpTravel=-0.000                   // travel to bumpstop with zero packers and zero ride height
ReboundTravel=-0.190                // these two numbers assume front ride height is 30cm to 90cm with 10cm leeway
BumpStopSpring=60000.0             // initial spring rate of bumpstop
BumpStopRisingSpring=1.25e9         // rising spring rate of bumpstop (multiplied by deflection squared)
BumpStopDamper=2500.0               // initial damping rate of bumpstop
BumpStopRisingDamper=2.19e7         // rising damper rate of bumpstop (multiplied by deflection squared)
BumpStage2=0.090                    // speed where damper bump moves from slow to fast
ReboundStage2=-0.090                // speed where damper rebound moves from slow to fast
FrictionTorque=9.50                 // Newton-meters of friction between spindle and wheel
SpinInertia=1.622                   // inertia in pitch direction including any axle
CGOffsetX=0.000                     // x-offset from graphical center to physical center (NOT IMPLEMENTED)
PushrodSpindle=(0.150, -0.150, 0.000) // relative to spindle
PushrodBody=(0.350, 0.320, 0.000)   // spring/damper connection to body (relative to wheel center)
CamberRange=(-5.0, 0.1, 100)
CamberSetting=35
PressureRange=(0.0, 1.0, 286)
PressureSetting=240
PackerRange=(0.000, 0.001, 30)
PackerSetting=0
SpringMult=1.0                  // take into account suspension motion if spring is not attached to spindle (affects physics but not garage display)
SpringRange=(45000.0, 7500.0, 6)
SpringSetting=0
RideHeightRange=(0.170, -0.0075, 10)
RideHeightSetting=0
DamperMult=1.0                    // take into account suspension motion if damper is not attached to spindle (affects physics but not garage display)
SlowBumpRange=(4000.0, 300.0, 11)
SlowBumpSetting=0
FastBumpRange=(2000.0, 200.0, 11)
FastBumpSetting=0
SlowReboundRange=(8000.0, 300.0, 16)
SlowReboundSetting=0
FastReboundRange=(4000.0, 300.0, 16)
FastReboundSetting=0
BrakeDiscRange=(0.035, 0.000, 0)    // disc thickness
BrakeDiscSetting=0
BrakePadRange=(0, 1, 5)             // pad type (not implemented)
BrakePadSetting=2
BrakeDiscInertia=0.001              // inertia per meter of thickness
BrakeOptimumTemp=450.0              // optimum brake temperature in Celsius
BrakeFadeRange=450.0               // temperature outside of optimum that brake grip drops to half (too hot or too cold)
BrakeWearRate=1.215e-011             // meters of wear per second at optimum temperature
BrakeFailure=(1.33e-002,7.20e-004)  // average and variation in disc thickness at failure
BrakeTorque=2600.0                  // maximum brake torque at zero wear and optimum temp
BrakeHeating=0.00055                 // heat added linearly with brake torque
BrakeCooling=(1.910e-002,0.667e-004)  // minimum brake cooling rate (static and per unit velocity)
BrakeDuctCooling=2.000e-004         // brake cooling rate per brake duct setting

[REARLEFT]
BumpTravel=-0.000                   // travel to bumpstop with zero packers and zero ride height
ReboundTravel=-0.200                // these two numbers assume rear ride height is 40cm to 100cm with 10cm leeway
BumpStopSpring=60000.0             // initial spring rate of bumpstop
BumpStopRisingSpring=1.25e9         // rising spring rate of bumpstop (multiplied by deflection squared)
BumpStopDamper=2500.0               // initial damping rate of bumpstop
BumpStopRisingDamper=2.19e7         // rising damper rate of bumpstop (multiplied by deflection squared)
BumpStage2=0.090                    // speed where damper bump moves from slow to fast
ReboundStage2=-0.090                // speed where damper rebound moves from slow to fast
FrictionTorque=12.50                 // Newton-meters of friction between spindle and wheel
SpinInertia=1.850                   // inertia in pitch direction including any axle
CGOffsetX=-0.030                     // x-offset from graphical center to physical center (NOT IMPLEMENTED)
PushrodSpindle=(-0.200, -0.150, 0.000) // relative to spindle
PushrodBody=(-0.400, 0.320, 0.000)       // spring/damper connection to body (relative to wheel center)
CamberRange=(-5.0, 0.1, 100)
CamberSetting=40
PressureRange=(0.0, 1.0, 286)
PressureSetting=230
PackerRange=(0.000, 0.001, 30)
PackerSetting=0
SpringMult=1.0                  // take into account suspension motion if spring is not attached to spindle (affects physics but not garage display)
SpringRange=(35000.0, 5833.0, 6)
SpringSetting=0
RideHeightRange=(0.180, -0.0075, 10)
RideHeightSetting=0
DamperMult=1.0                     // take into account suspension motion if damper is not attached to spindle (affects physics but not garage display)
SlowBumpRange=(4000.0, 300.0, 11)
SlowBumpSetting=0
FastBumpRange=(2000.0, 200.0, 11)
FastBumpSetting=0
SlowReboundRange=(8000.0, 300.0, 16)
SlowReboundSetting=0
FastReboundRange=(4000.0, 300.0, 16)
FastReboundSetting=0
BrakeDiscRange=(0.032, 0.000, 0)    // disc thickness
BrakeDiscSetting=0
BrakePadRange=(0, 1, 5)             // pad type (not implemented)
BrakePadSetting=2
BrakeDiscInertia=0.001              // inertia per meter of thickness
BrakeOptimumTemp=450.0              // optimum brake temperature in Celsius (peak brake grip)
BrakeFadeRange=450.0               // temperature outside of optimum that brake grip drops to half (too hot or too cold)
BrakeWearRate=1.215e-011             // meters of wear per second at optimum temperature
BrakeFailure=(1.33e-002,7.20e-004)  // average and variation in disc thickness at failure
BrakeTorque=1800.0                  // maximum brake torque at zero wear and optimum temp
BrakeHeating=0.00055                 // heat added linearly with brake torque
BrakeCooling=(1.417e-002,0.495e-004)  // minimum brake cooling rate (static and per unit velocity)
BrakeDuctCooling=1.600e-004         // brake cooling rate per brake duct setting


[REARRIGHT]
BumpTravel=-0.000                   // travel to bumpstop with zero packers and zero ride height
ReboundTravel=-0.200                // these two numbers assume rear ride height is 40cm to 100cm with 10cm leeway
BumpStopSpring=60000.0             // initial spring rate of bumpstop
BumpStopRisingSpring=1.25e9         // rising spring rate of bumpstop (multiplied by deflection squared)
BumpStopDamper=2500.0               // initial damping rate of bumpstop
BumpStopRisingDamper=2.19e7         // rising damper rate of bumpstop (multiplied by deflection squared)
BumpStage2=0.090                    // speed where damper bump moves from slow to fast
ReboundStage2=-0.090                // speed where damper rebound moves from slow to fast
FrictionTorque=12.50                 // Newton-meters of friction between spindle and wheel
SpinInertia=1.850                   // inertia in pitch direction including any axle
CGOffsetX=-0.030                     // x-offset from graphical center to physical center (NOT IMPLEMENTED)
PushrodSpindle=(0.200, -0.150, 0.000) // relative to spindle
PushrodBody=(0.400, 0.320, 0.000)       // spring/damper connection to body (relative to wheel center)
CamberRange=(-5.0, 0.1, 100)
CamberSetting=40
PressureRange=(0.0, 1.0, 286)
PressureSetting=230
PackerRange=(0.000, 0.001, 30)
PackerSetting=0
SpringMult=1.0                // take into account suspension motion if spring is not attached to spindle (affects physics but not garage display)
SpringRange=(35000.0, 5833.0, 6)
SpringSetting=0
RideHeightRange=(0.180, -0.075, 10)
RideHeightSetting=0
DamperMult=1.0                     // take into account suspension motion if damper is not attached to spindle (affects physics but not garage display)
SlowBumpRange=(4000.0, 300.0, 11)
SlowBumpSetting=0
FastBumpRange=(2000.0, 200.0, 11)
FastBumpSetting=0
SlowReboundRange=(8000.0, 300.0, 16)
SlowReboundSetting=0
FastReboundRange=(4000.0, 300.0, 16)
FastReboundSetting=0
BrakeDiscRange=(0.032, 0.000, 0)    // disc thickness
BrakeDiscSetting=0
BrakePadRange=(0, 1, 5)             // pad type (not implemented)
BrakePadSetting=2
BrakeDiscInertia=0.001              // inertia per meter of thickness
BrakeOptimumTemp=450.0              // optimum brake temperature in Celsius (peak brake grip)
BrakeFadeRange=450.0               // temperature outside of optimum that brake grip drops to half (too hot or too cold)
BrakeWearRate=1.215e-011             // meters of wear per second at optimum temperature
BrakeFailure=(1.33e-002,7.20e-004)  // average and variation in disc thickness at failure
BrakeTorque=1800.0                  // maximum brake torque at zero wear and optimum temp
BrakeHeating=0.00055                 // heat added linearly with brake torque
BrakeCooling=(1.417e-002,0.495e-004)  // minimum brake cooling rate (static and per unit velocity)
BrakeDuctCooling=1.600e-004         // brake cooling rate per brake duct setting

