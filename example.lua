local inv = require('inventory')

    -- Hasso Mode 2 (Example: Hasso+, with a focus on Multi-Attack, Zanshin, and Store TP, with enough DT to survive higher end content)
    sets.hasso.Mode2 = set_combine(sets.hasso.Mode1, {
        ammo = inv.coiste_bodhar,
        head = inv.kasuga_head,
        body = inv.kasuga_body,
        hands = inv.mpacas_gloves,
        legs = inv.kasuga_legs,
        feet = inv.tatenashi_feet,
        neck = inv.sams_nodowa,
        waist = inv.sailfi_belt,
        left_ear = inv.schere_earring,
        right_ear = inv.kasuga_earring,
        left_ring = inv.chirich_ring,
        right_ring = inv.niqmaddu_ring,
        back = inv.SAM_TP_CAPE_DT,
    })
