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

public final class EOchar extends PhDefault {
    public EOchar() {
        this(new PhEta());
    }

    public EOchar(Phi parent) {
        super(parent);
        this.add("Δ", new AtFree());
        this.add("data", new AtFree());
    }
}
