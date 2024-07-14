package org.amagana.System;

import org.amagana.View.Login;

/**
 *
 * @author angel
 */
public class Main {

    public static void main(String[] args) {
        Login log = Login.getInstancia();
        
        try {
            log.setVisible(true);
            log.setLocationRelativeTo(null);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
