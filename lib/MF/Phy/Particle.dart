import '../Geo/Linear/Vec.dart';
import 'PhyEnv.dart';

class Particle {
  Vec p = Vec();
  Vec v = Vec();
  Vec a = Vec();
  PhyEnv env = PhyEnv();

  Particle(this.p, this.v, this.a);

  bool onUpdate() {
    v = v  + a * env.dt;
    p = p  + v * env.dt;
    return true;
  }


}