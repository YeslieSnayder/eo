//
// Source code recreated from a .class file by IntelliJ IDEA
// (powered by FernFlower decompiler)
//

package org.eolang;

import org.eolang.phi.AtBound;
import org.eolang.phi.AtFree;
import org.eolang.phi.AtLambda;
import org.eolang.phi.AtOnce;
import org.eolang.phi.PhCopy;
import org.eolang.phi.PhDefault;
import org.eolang.phi.PhEta;
import org.eolang.phi.Phi;

public final class EOregex extends PhDefault {
    public EOregex() {
        this(new PhEta());
    }

    public EOregex(Phi parent) {
        super(parent);
        this.add("Δ", new AtFree());
        this.add("match", new AtBound(new AtOnce(new AtLambda(this, (self) -> {
            Phi ret = new EOregex$EOmatch(self);
            Phi retx = new PhCopy(ret);
            return retx;
        }))));
        this.add("matches", new AtBound(new AtOnce(new AtLambda(this, (self) -> {
            Phi ret = new EOregex(self);
            Phi retx = new PhCopy(ret);
            return retx;
        }))));
    }
}
