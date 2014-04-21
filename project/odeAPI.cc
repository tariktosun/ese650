/*
   status = odeAPI(args);

   Matlab MEX file to interface to ODE library.

   Compile with:
   mex -O odeAPI.cc -I/usr/local/include -L/usr/local/lib -lode

   Written by Daniel D. Lee, <ddlee@seas.upenn.edu>, 2/2009
*/

#include <vector>
#include <ode/ode.h>
#include "mex.h"

#define MAX_CONTACTS 32

bool init = false;
dWorldID world;
dSpaceID space;

std::vector <dBodyID> body;
std::vector <dGeomID> geom;
std::vector <dJointID> joint;
dJointGroupID contactGroup;

void mexExit(void) {
  dJointGroupDestroy(contactGroup);
  dSpaceDestroy(space);
  dWorldDestroy(world);
  dCloseODE();
}

void nearCallback(void *unused, dGeomID o1, dGeomID o2) {
  dBodyID body1 = dGeomGetBody(o1);
  dBodyID body2 = dGeomGetBody(o2);
  dContact contact[MAX_CONTACTS];

  int collisions = dCollide(o1, o2, MAX_CONTACTS,
			    &contact[0].geom, sizeof(dContact));
  for (int i = 0; i < collisions; i++) {
    contact[i].surface.mode = dContactBounce | dContactSoftCFM;
    contact[i].surface.mu = dInfinity;
    contact[i].surface.mu2 = 0.0;
    contact[i].surface.bounce = 0.01;
    //    contact[i].surface.bounce = 0.5;
    contact[i].surface.bounce_vel = 0.01;
    contact[i].surface.soft_cfm = 0.01;

    dJointID c = dJointCreateContact(world, contactGroup, contact+i);
    dJointAttach(c, body1, body2);
  }
}

int paramName(const mxArray *array)
{
  const int buflen = 80;
  char buf[buflen];
  
  if (mxGetString(array, buf, buflen) != 0) 
    mexErrMsgTxt("Could not read string.");

  if (strcmp(buf, "LoStop") == 0) return dParamLoStop;
  else if (strcmp(buf, "HiStop") == 0) return dParamHiStop;
  else if (strcmp(buf, "Vel") == 0)  return dParamVel;
  else if (strcmp(buf, "FMax") == 0)  return dParamFMax;
  else if (strcmp(buf, "FudgeFactor") == 0)  return dParamFudgeFactor;
  else if (strcmp(buf, "Bounce") == 0)  return dParamBounce;
  else if (strcmp(buf, "CFM") == 0)  return dParamCFM;
  else if (strcmp(buf, "StopERP") == 0)  return dParamStopERP;
  else if (strcmp(buf, "StopCFM") == 0)  return dParamStopCFM;
  else if (strcmp(buf, "SuspensionERP") == 0)  return dParamSuspensionERP;
  else if (strcmp(buf, "SuspensionCFM") == 0)  return dParamSuspensionCFM; 
  else if (strcmp(buf, "LoStop2") == 0) return dParamLoStop2;
  else if (strcmp(buf, "HiStop2") == 0) return dParamHiStop2;
  else if (strcmp(buf, "Vel2") == 0)  return dParamVel2;
  else if (strcmp(buf, "FMax2") == 0)  return dParamFMax2;
  else if (strcmp(buf, "FudgeFactor2") == 0)  return dParamFudgeFactor2;
  else if (strcmp(buf, "Bounce2") == 0)  return dParamBounce2;
  else if (strcmp(buf, "CFM2") == 0)  return dParamCFM2;
  else if (strcmp(buf, "StopERP2") == 0)  return dParamStopERP2;
  else if (strcmp(buf, "StopCFM2") == 0)  return dParamStopCFM2;
  else if (strcmp(buf, "LoStop3") == 0) return dParamLoStop3;
  else if (strcmp(buf, "HiStop3") == 0) return dParamHiStop3;
  else if (strcmp(buf, "Vel3") == 0)  return dParamVel3;
  else if (strcmp(buf, "FMax3") == 0)  return dParamFMax3;
  else if (strcmp(buf, "FudgeFactor3") == 0)  return dParamFudgeFactor3;
  else if (strcmp(buf, "Bounce3") == 0)  return dParamBounce3;
  else if (strcmp(buf, "CFM3") == 0)  return dParamCFM3;
  else if (strcmp(buf, "StopERP3") == 0)  return dParamStopERP3;
  else if (strcmp(buf, "StopCFM3") == 0)  return dParamStopCFM3;
  else
    mexErrMsgTxt("Unknown parameter name;");
  
  return 0;
}

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
  const int buflen = 65536;
  char buf[buflen];
  int ret = 0;

  // Get input arguments
  if (nrhs == 0) {
    mexErrMsgTxt("Need input argument");
    return;
  }

  if (mxGetString(prhs[0], buf, buflen) != 0) 
    mexErrMsgTxt("Could not read string.");

  if (!init) {
    dInitODE();
    world = dWorldCreate();
    dWorldSetGravity(world, 0, 0, -9.81);
    space = dSimpleSpaceCreate(0);
    contactGroup = dJointGroupCreate(0);

    dWorldSetERP(world, 0.2);
    dWorldSetCFM(world, 1e-5);
    dWorldSetContactMaxCorrectingVel(world, 0.9);
    dWorldSetContactSurfaceLayer(world, 0.001);

    mexAtExit(mexExit);
    init = true;
  }

  // Stepping functions
  if (strcmp(buf, "worldStep") == 0) {
    float stepsize = mxGetScalar(prhs[1]); 
    dSpaceCollide(space, NULL, &nearCallback);
    dWorldStep(world, stepsize);
    dJointGroupEmpty(contactGroup);
  }
  else if (strcmp(buf, "worldQuickStep") == 0) {
    float stepsize = mxGetScalar(prhs[1]); 
    dSpaceCollide(space, NULL, &nearCallback);
    dWorldQuickStep(world, stepsize);
    dJointGroupEmpty(contactGroup);
  }

  // Rigid body functions
  else if (strcmp(buf, "bodyCreate") == 0) {
    body.push_back(dBodyCreate(world));
    ret = body.size() - 1;
  }
  else if (strcmp(buf, "bodySetMass") == 0) {
    int index = mxGetScalar(prhs[1]);
    double themass = mxGetScalar(prhs[2]);
    double *x = mxGetPr(prhs[3]);
    dMass mass;
    mass.mass = themass;
    for (int i = 0; i < 12; i++) mass.I[i] = x[i];
    dBodySetMass(body[index], &mass);
  }
  else if (strcmp(buf, "bodySetMassSphere") == 0) {
    int index = mxGetScalar(prhs[1]);
    double themass = mxGetScalar(prhs[2]);
    double radius = mxGetScalar(prhs[3]);
    dMass mass;
    dMassSetSphereTotal(&mass, themass, radius);
    dBodySetMass(body[index], &mass);
  }
  else if (strcmp(buf, "bodySetMassCylinder") == 0) {
    int index = mxGetScalar(prhs[1]);
    double themass = mxGetScalar(prhs[2]);
    double *x = mxGetPr(prhs[3]);
    dMass mass;
    dMassSetCylinderTotal(&mass, themass, (int) x[0], x[1], x[2]);
    dBodySetMass(body[index], &mass);
  }
  else if (strcmp(buf, "bodySetMassBox") == 0) {
    int index = mxGetScalar(prhs[1]);
    double themass = mxGetScalar(prhs[2]);
    double *x = mxGetPr(prhs[3]);
    dMass mass;
    dMassSetBoxTotal(&mass, themass, x[0], x[1], x[2]);
    dBodySetMass(body[index], &mass);
  }
  else if (strcmp(buf, "bodyGetMass") == 0) {
    int index = mxGetScalar(prhs[1]);
    dMass mass;
    dBodyGetMass(body[index], &mass);
    const char *fields[] = {"mass", "c", "I"};
    const int nfields = sizeof(fields)/sizeof(*fields);
    plhs[0] = mxCreateStructMatrix(1, 1, nfields, fields);
    mxArray *mxMass = mxCreateDoubleScalar(mass.mass);
    mxSetField(plhs[0], 0, "mass", mxMass);
    mxArray *mxC = mxCreateDoubleMatrix(4, 1, mxREAL);
    for (int i = 0; i < 4; i++) mxGetPr(mxC)[i] = mass.c[i];
    mxSetField(plhs[0], 0, "c", mxC);
    mxArray *mxI = mxCreateDoubleMatrix(4, 3, mxREAL);
    for (int i = 0; i < 12; i++) mxGetPr(mxI)[i] = mass.I[i];
    mxSetField(plhs[0], 0, "I", mxI);
    return;
  }
  else if (strcmp(buf, "bodyMassAdjust") == 0) {
    int index = mxGetScalar(prhs[1]);
    float newmass = mxGetScalar(prhs[2]);
    dMass mass;
    dBodyGetMass(body[index], &mass);
    dMassAdjust(&mass, newmass);
    dBodySetMass(body[index], &mass);
  }
  else if (strcmp(buf, "bodySetPosition") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dBodySetPosition(body[index], x[0], x[1], x[2]);
  }
  else if (strcmp(buf, "bodyGetPosition") == 0) {
    int index = mxGetScalar(prhs[1]);
    const dReal *pos = dBodyGetPosition(body[index]);
    plhs[0] = mxCreateDoubleMatrix(3,1,mxREAL);
    double *x = mxGetPr(plhs[0]);
    for (int i = 0 ; i < 3; i++) x[i] = pos[i];
    return;
  }
  else if (strcmp(buf, "bodySetRotation") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dMatrix3 R;
    for (int i = 0; i < 12; i++) R[i] = x[i];
    dBodySetRotation(body[index], R);
  }
  else if (strcmp(buf, "bodyGetRotation") == 0) {
    int index = mxGetScalar(prhs[1]);
    const dReal *R = dBodyGetRotation(body[index]);
    plhs[0] = mxCreateDoubleMatrix(4,3,mxREAL);
    double *x = mxGetPr(plhs[0]);
    for (int i = 0 ; i < 12; i++) x[i] = R[i];
    return;
  }
  else if (strcmp(buf, "bodySetQuaternion") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dQuaternion q;
    for (int i = 0; i < 4; i++) q[i] = x[i];
    dBodySetQuaternion(body[index], q);
  }
  else if (strcmp(buf, "bodyGetQuaternion") == 0) {
    int index = mxGetScalar(prhs[1]);
    const dReal *q = dBodyGetQuaternion(body[index]);
    plhs[0] = mxCreateDoubleMatrix(4,1,mxREAL);
    double *x = mxGetPr(plhs[0]);
    for (int i = 0 ; i < 4; i++) x[i] = q[i];
    return;
  }
  else if (strcmp(buf, "bodySetLinearVel") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dBodySetLinearVel(body[index], x[0], x[1], x[2]);
  }
  else if (strcmp(buf, "bodyGetLinearVel") == 0) {
    int index = mxGetScalar(prhs[1]);
    const dReal *v = dBodyGetLinearVel(body[index]);
    plhs[0] = mxCreateDoubleMatrix(3,1,mxREAL);
    double *x = mxGetPr(plhs[0]);
    for (int i = 0 ; i < 3; i++) x[i] = v[i];
    return;
  }
  else if (strcmp(buf, "bodySetAngularVel") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dBodySetAngularVel(body[index], x[0], x[1], x[2]);
  }
  else if (strcmp(buf, "bodyGetAngularVel") == 0) {
    int index = mxGetScalar(prhs[1]);
    const dReal *v = dBodyGetAngularVel(body[index]);
    plhs[0] = mxCreateDoubleMatrix(3,1,mxREAL);
    double *x = mxGetPr(plhs[0]);
    for (int i = 0 ; i < 3; i++) x[i] = v[i];
    return;
  }

  // Collision geometry
  else if (strcmp(buf, "geomSetBody") == 0) {
    int geom_index = mxGetScalar(prhs[1]);
    int body_index = mxGetScalar(prhs[2]);
    dGeomSetBody(geom[geom_index], body[body_index]);
  }
  else if (strcmp(buf, "createPlane") == 0) {
    double *x = mxGetPr(prhs[1]);
    geom.push_back(dCreatePlane(space, x[0], x[1], x[2], x[3]));
    ret = geom.size() - 1;
  }
  else if (strcmp(buf, "createSphere") == 0) {
    double radius = mxGetScalar(prhs[1]);
    geom.push_back(dCreateSphere(space, radius));
    ret = geom.size() - 1;
  }
  else if (strcmp(buf, "createBox") == 0) {
    double *x = mxGetPr(prhs[1]);
    geom.push_back(dCreateBox(space, x[0], x[1], x[2]));
    ret = geom.size() - 1;
  }
  else if (strcmp(buf, "createCylinder") == 0) {
    double *x = mxGetPr(prhs[1]);
    geom.push_back(dCreateCylinder(space, x[0], x[1]));
    ret = geom.size() - 1;
  }
  else if (strcmp(buf, "createCCylinder") == 0) {
    double *x = mxGetPr(prhs[1]);
    geom.push_back(dCreateCCylinder(space, x[0], x[1]));
    ret = geom.size() - 1;
  }

  // Joint functions
  else if (strcmp(buf, "jointAttach") == 0) {
    int joint_index = mxGetScalar(prhs[1]);
    int body1_index = mxGetScalar(prhs[2]);
    int body2_index = mxGetScalar(prhs[3]);
    dJointAttach(joint[joint_index],
		 body[body1_index], body[body2_index]);
  }
  else if (strcmp(buf, "jointCreateBall") == 0) {
    joint.push_back(dJointCreateBall(world, 0));
    ret = joint.size() - 1;
  }
  else if (strcmp(buf, "jointSetBallAnchor") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dJointSetBallAnchor(joint[index], x[0], x[1], x[2]);
  }
  else if (strcmp(buf, "jointCreateUniversal") == 0) {
    joint.push_back(dJointCreateUniversal(world, 0));
    ret = joint.size() - 1;
  }
  else if (strcmp(buf, "jointSetUniversalAnchor") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dJointSetUniversalAnchor(joint[index], x[0], x[1], x[2]);
  }
  else if (strcmp(buf, "jointSetUniversalAxis1") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dJointSetUniversalAxis1(joint[index], x[0], x[1], x[2]);
  }
  else if (strcmp(buf, "jointSetUniversalAxis2") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dJointSetUniversalAxis2(joint[index], x[0], x[1], x[2]);
  }
  else if (strcmp(buf, "jointGetUniversalAngle1") == 0) {
    int index = mxGetScalar(prhs[1]);
    plhs[0] = mxCreateDoubleScalar(dJointGetUniversalAngle1(joint[index]));
    return;
  }
  else if (strcmp(buf, "jointGetUniversalAngle2") == 0) {
    int index = mxGetScalar(prhs[1]);
    plhs[0] = mxCreateDoubleScalar(dJointGetUniversalAngle2(joint[index]));
    return;
  }
  else if (strcmp(buf, "jointGetUniversalAngle1Rate") == 0) {
    int index = mxGetScalar(prhs[1]);
    plhs[0] = mxCreateDoubleScalar(dJointGetUniversalAngle1Rate(joint[index]));
    return;
  }
  else if (strcmp(buf, "jointGetUniversalAngle2Rate") == 0) {
    int index = mxGetScalar(prhs[1]);
    plhs[0] = mxCreateDoubleScalar(dJointGetUniversalAngle2Rate(joint[index]));
    return;
  }
  else if (strcmp(buf, "jointSetUniversalParam") == 0) {
    int index = mxGetScalar(prhs[1]);
    int parameter = paramName(prhs[2]);
    double value = mxGetScalar(prhs[3]);
    dJointSetUniversalParam(joint[index], parameter, value);
  }
  else if (strcmp(buf, "jointGetUniversalParam") == 0) {
    int index = mxGetScalar(prhs[1]);
    int parameter = paramName(prhs[2]);
    double value = dJointGetUniversalParam(joint[index], parameter);
    plhs[0] = mxCreateDoubleScalar(value);
    return;
  }
  else if (strcmp(buf, "jointCreateHinge") == 0) {
    joint.push_back(dJointCreateHinge(world, 0));
    ret = joint.size() - 1;
  }
  else if (strcmp(buf, "jointSetHingeAnchor") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dJointSetHingeAnchor(joint[index], x[0], x[1], x[2]);
  }
  else if (strcmp(buf, "jointSetHingeAxis") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dJointSetHingeAxis(joint[index], x[0], x[1], x[2]);
  }
  else if (strcmp(buf, "jointGetHingeAngle") == 0) {
    int index = mxGetScalar(prhs[1]);
    plhs[0] = mxCreateDoubleScalar(dJointGetHingeAngle(joint[index]));
    return;
  }
  else if (strcmp(buf, "jointGetHingeAngleRate") == 0) {
    int index = mxGetScalar(prhs[1]);
    plhs[0] = mxCreateDoubleScalar(dJointGetHingeAngleRate(joint[index]));
    return;
  }
  else if (strcmp(buf, "jointSetHingeParam") == 0) {
    int index = mxGetScalar(prhs[1]);
    int parameter = paramName(prhs[2]);
    double value = mxGetScalar(prhs[3]);
    dJointSetHingeParam(joint[index], parameter, value);
  }
  else if (strcmp(buf, "jointGetHingeParam") == 0) {
    int index = mxGetScalar(prhs[1]);
    int parameter = paramName(prhs[2]);
    double value = dJointGetHingeParam(joint[index], parameter);
    plhs[0] = mxCreateDoubleScalar(value);
    return;
  }
  else if (strcmp(buf, "jointGetHingeAnchor") == 0) {
    int index = mxGetScalar(prhs[1]);
    dVector3 result;
    dJointGetHingeAnchor(joint[index], result);
    plhs[0] = mxCreateDoubleMatrix(3, 1, mxREAL);
    double *x = mxGetPr(plhs[0]);
    for (int i=0; i < 3; i++) x[i] = result[i];
    return;
  }
  else if (strcmp(buf, "jointGetHingeAnchor2") == 0) {
    int index = mxGetScalar(prhs[1]);
    dVector3 result;
    dJointGetHingeAnchor2(joint[index], result);
    plhs[0] = mxCreateDoubleMatrix(3, 1, mxREAL);
    double *x = mxGetPr(plhs[0]);
    for (int i=0; i < 3; i++) x[i] = result[i];
    return;
  }
  else if (strcmp(buf, "jointCreateSlider") == 0) {
    joint.push_back(dJointCreateSlider(world, 0));
    ret = joint.size() - 1;
  }
  else if (strcmp(buf, "jointSetSliderAxis") == 0) {
    int index = mxGetScalar(prhs[1]);
    double *x = mxGetPr(prhs[2]);
    dJointSetSliderAxis(joint[index], x[0], x[1], x[2]);
  }
  else if (strcmp(buf, "jointGetSliderAxis") == 0) {
    int index = mxGetScalar(prhs[1]);
    dVector3 result;
    dJointGetSliderAxis(joint[index], result);
    plhs[0] = mxCreateDoubleMatrix(3, 1, mxREAL);
    double *x = mxGetPr(plhs[0]);
    for (int i=0; i < 3; i++) x[i] = result[i];
    return;
  }
  else if (strcmp(buf, "jointGetSliderPosition") == 0) {
    int index = mxGetScalar(prhs[1]);
    plhs[0] = mxCreateDoubleScalar(dJointGetSliderPosition(joint[index]));
    return;
  }
  else if (strcmp(buf, "jointGetSliderPositionRate") == 0) {
    int index = mxGetScalar(prhs[1]);
    plhs[0] = mxCreateDoubleScalar(dJointGetSliderPositionRate(joint[index]));
    return;
  }
  else if (strcmp(buf, "jointSetSliderParam") == 0) {
    int index = mxGetScalar(prhs[1]);
    int parameter = paramName(prhs[2]);
    double value = mxGetScalar(prhs[3]);
    dJointSetSliderParam(joint[index], parameter, value);
  }
  else if (strcmp(buf, "jointGetSliderParam") == 0) {
    int index = mxGetScalar(prhs[1]);
    int parameter = paramName(prhs[2]);
    double value = dJointGetSliderParam(joint[index], parameter);
    plhs[0] = mxCreateDoubleScalar(value);
    return;
  }
  else if (strcmp(buf, "jointCreateAMotor") == 0) {
    joint.push_back(dJointCreateAMotor(world, 0));
    ret = joint.size() - 1;
  }

  else {
    mexErrMsgTxt("Unknown option");
  }

  // Return default output:
  plhs[0] = mxCreateDoubleScalar(ret);
}
