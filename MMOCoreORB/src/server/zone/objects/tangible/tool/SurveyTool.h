/*
 *	server/zone/objects/tangible/tool/SurveyTool.h generated by engine3 IDL compiler 0.60
 */

#ifndef SURVEYTOOL_H_
#define SURVEYTOOL_H_

#include "engine/orb/DistributedObjectBroker.h"

#include "engine/core/ManagedReference.h"

#include "engine/core/ManagedWeakReference.h"

namespace server {
namespace zone {
namespace objects {
namespace player {

class PlayerCreature;

} // namespace player
} // namespace objects
} // namespace zone
} // namespace server

using namespace server::zone::objects::player;

namespace server {
namespace zone {
namespace packets {
namespace object {

class ObjectMenuResponse;

} // namespace object
} // namespace packets
} // namespace zone
} // namespace server

using namespace server::zone::packets::object;

namespace server {
namespace zone {
namespace objects {
namespace scene {

class SceneObject;

} // namespace scene
} // namespace objects
} // namespace zone
} // namespace server

using namespace server::zone::objects::scene;

namespace server {
namespace zone {

class Zone;

} // namespace zone
} // namespace server

using namespace server::zone;

#include "server/zone/objects/tangible/tool/ToolTangibleObject.h"

#include "engine/lua/LuaObject.h"

namespace server {
namespace zone {
namespace objects {
namespace tangible {
namespace tool {

class SurveyTool : public ToolTangibleObject {
public:
	static const int SOLAR = 1;

	static const int CHEMICAL = 2;

	static const int FLORA = 3;

	static const int GAS = 4;

	static const int GEOTHERMAL = 5;

	static const int MINERAL = 6;

	static const int WATER = 7;

	static const int WIND = 8;

	static const int FUSION = 9;

	SurveyTool();

	void initializeTransientMembers();

	void loadTemplateData(SharedObjectTemplate* templateData);

	void fillObjectMenuResponse(ObjectMenuResponse* menuResponse, PlayerCreature* player);

	void setRange(int r);

	int getRange();

	int getPoints();

	bool canSampleRadioactive();

	void consentRadioactiveSample();

	void sendRadioactiveWarning(PlayerCreature* playerCreature);

	void sendRangeSui(PlayerCreature* playerCreature);

	int handleObjectMenuSelect(PlayerCreature* player, byte selectedID);

	void sendResourceListTo(PlayerCreature* playerCreature);

	void sendSurveyTo(PlayerCreature* playerCreature, const String& resname);

	void sendSampleTo(PlayerCreature* playerCreature, const String& resname);

protected:
	SurveyTool(DummyConstructorParameter* param);

	virtual ~SurveyTool();

	friend class SurveyToolHelper;
};

} // namespace tool
} // namespace tangible
} // namespace objects
} // namespace zone
} // namespace server

using namespace server::zone::objects::tangible::tool;

namespace server {
namespace zone {
namespace objects {
namespace tangible {
namespace tool {

class SurveyToolImplementation : public ToolTangibleObjectImplementation {
protected:
	int range;

	int points;

	int type;

	String surveyType;

	String surveyAnimation;

	String sampleAnimation;

	String lastResourceSampleName;

	bool radioactiveOk;

public:
	static const int SOLAR = 1;

	static const int CHEMICAL = 2;

	static const int FLORA = 3;

	static const int GAS = 4;

	static const int GEOTHERMAL = 5;

	static const int MINERAL = 6;

	static const int WATER = 7;

	static const int WIND = 8;

	static const int FUSION = 9;

	SurveyToolImplementation();

	SurveyToolImplementation(DummyConstructorParameter* param);

	void initializeTransientMembers();

	void loadTemplateData(SharedObjectTemplate* templateData);

	void fillObjectMenuResponse(ObjectMenuResponse* menuResponse, PlayerCreature* player);

	void setRange(int r);

	int getRange();

	int getPoints();

	bool canSampleRadioactive();

	void consentRadioactiveSample();

	void sendRadioactiveWarning(PlayerCreature* playerCreature);

	void sendRangeSui(PlayerCreature* playerCreature);

	int handleObjectMenuSelect(PlayerCreature* player, byte selectedID);

	void sendResourceListTo(PlayerCreature* playerCreature);

	void sendSurveyTo(PlayerCreature* playerCreature, const String& resname);

	void sendSampleTo(PlayerCreature* playerCreature, const String& resname);

	SurveyTool* _this;

	operator const SurveyTool*();

	DistributedObjectStub* _getStub();
protected:
	virtual ~SurveyToolImplementation();

	void finalize();

	void _initializeImplementation();

	void _setStub(DistributedObjectStub* stub);

	void lock(bool doLock = true);

	void lock(ManagedObject* obj);

	void rlock(bool doLock = true);

	void wlock(bool doLock = true);

	void wlock(ManagedObject* obj);

	void unlock(bool doLock = true);

	void runlock(bool doLock = true);

	void _serializationHelperMethod();

	friend class SurveyTool;
};

class SurveyToolAdapter : public ToolTangibleObjectAdapter {
public:
	SurveyToolAdapter(SurveyToolImplementation* impl);

	Packet* invokeMethod(sys::uint32 methid, DistributedMethod* method);

	void initializeTransientMembers();

	void setRange(int r);

	int getRange();

	int getPoints();

	bool canSampleRadioactive();

	void consentRadioactiveSample();

	void sendRadioactiveWarning(PlayerCreature* playerCreature);

	void sendRangeSui(PlayerCreature* playerCreature);

	int handleObjectMenuSelect(PlayerCreature* player, byte selectedID);

	void sendResourceListTo(PlayerCreature* playerCreature);

	void sendSurveyTo(PlayerCreature* playerCreature, const String& resname);

	void sendSampleTo(PlayerCreature* playerCreature, const String& resname);

protected:
	String _param1_sendSurveyTo__PlayerCreature_String_;
	String _param1_sendSampleTo__PlayerCreature_String_;
};

class SurveyToolHelper : public DistributedObjectClassHelper, public Singleton<SurveyToolHelper> {
	static SurveyToolHelper* staticInitializer;

public:
	SurveyToolHelper();

	void finalizeHelper();

	DistributedObject* instantiateObject();

	DistributedObjectServant* instantiateServant();

	DistributedObjectAdapter* createAdapter(DistributedObjectStub* obj);

	friend class Singleton<SurveyToolHelper>;
};

} // namespace tool
} // namespace tangible
} // namespace objects
} // namespace zone
} // namespace server

using namespace server::zone::objects::tangible::tool;

#endif /*SURVEYTOOL_H_*/
