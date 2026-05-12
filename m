Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F01A399888
	for <audit@vger.kernel.org>; Tue, 12 May 2026 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778592563; cv=none; b=UUFX/+E6fOshLHBsEA2HcfkcDJwtvVWxT77bmhTO5QESX8Nv+0C4E1UaMR9TVYxK5AXT6VWQ6R1zoTWGrP3Ic8LlLfhbAfVyOdJTQlf/XVHjgfWcLnOcdl6lSct0qC1Bsz/aolJIekSRyfhUhEv2rD6Ha2eei7qbNvVGgm99EJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778592563; c=relaxed/simple;
	bh=XSO6/ehUzxMv/7XxOjtr/w6uDvN382q+w4cM50UyVto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=hqIfbUkDU2HqKz0WgewVD7ETdklmp0sqLAI50pjWz8L21DKChajYLBrihbouglqr9qx6u9CwOqMP0dM31eIurEOzmSXC2srLQmDfu31clYqoeNbATgOT1Mheoxxcg9YPL6Ot3DT0EKCaVCv6EAUE745vMB28UEQuHBFBbhDsuOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BZlc4jIi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BZlc4jIi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778592561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=SUwxbpfSV6QCUEVIOKvo2a276KonpMYKzJg4k5y+Cw8=;
	b=BZlc4jIiAa+LHxfpJ1FmuEeUaf7eoY4wOFy5Cer8H3XFcRhVmiIVRG1NswUkIFBoN6udxt
	UvqE32TA6O1A8D7H5Aedl8Yc8+a2FNVoSGATaoywq4GVBmaCHd/inBHAWIW3lgBklfKD0p
	HYpHyp/eIO8xpg/ZGBiec3aHIVrX6Oo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-JNeZkDAMPyKGEQDVweEjmw-1; Tue, 12 May 2026 09:29:20 -0400
X-MC-Unique: JNeZkDAMPyKGEQDVweEjmw-1
X-Mimecast-MFC-AGG-ID: JNeZkDAMPyKGEQDVweEjmw_1778592559
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-44f56d5523eso4557700f8f.1
        for <audit@vger.kernel.org>; Tue, 12 May 2026 06:29:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778592559; x=1779197359;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SUwxbpfSV6QCUEVIOKvo2a276KonpMYKzJg4k5y+Cw8=;
        b=JVctVvl7wEc8/oQzPiCObaMZbaDSp9kZDlMIaBIwtfoxonwGKpmPGn8w08rkxo1OSF
         fUevr0C2+vLzfZrMC5nfditiHrVTFgCRSR52DoPMP6CFD3XOa2le1KiwaeV/mpukwmaV
         5m5O9XU8nu2DqVTA7FNfEnVPcDSxEoKzicy3+djMc4v4dOdMx3yd0El0mhYwU1A9hAjD
         tL33d4WuuAx31mmr/+X0pl3KwwYFE7UxXQCTPyvj5/bsBIyZI0R28E+2xzwiPMzbCB6t
         BafavNO9j6pQosMXYrKJczG+DUWFEBjncFlJ1BOcefszVGEzrOzK4uGqNECnlvuvZbWu
         5WGQ==
X-Gm-Message-State: AOJu0YxqWgygjB9hXQ2Pl8yCv3lumn/iiDmqIfBzaZL9/y2hR8Kofnve
	W6vDfLxgTtsy79CVv29x101S7mD1a5qC7VA/o/AoB+GLRF7pZYHSkUfhdJ+TEJtMaqpnNS6MgSW
	c21n9zG5Qnjng9LWGuB9S2teagooJSMFsSFIVcbYXH0JaPl9AB5CmMW146JIZIROO+zNZjk1ijS
	Vvdrj/hS1aOYkP6dHGfgwHfHFG3R7TOlQDauOQlQ0XSNo=
X-Gm-Gg: Acq92OH3YG2pfH3zpQkqdaBM+ZVwLV0+yyRrH4LPpL2mE7a1GV9Mg2dMa5rk8+UBjb7
	so9lL84YHCJeLTB2LYgaNXTESxhWwyFW0PO7P6UWTpeAignMMfkbWp/rYPGJRlCUDIesy8jYu1w
	aBczu8AK+ESqlpR2RNTofY3nPtPiKXSF3Ngr06DHFF4czID5IFirEh5uLN2vEacYwiqlypwHdnc
	JMIzMTR16efT2tdgMIMeAAUxCtt7+81f2G9na59PMB+D/cDp2XRFC6GB1xalOHbnTs5NkKxMBQl
	mhnwkeFnA8qwOk5w962QWhAqusEh2btakrrm6PscQXo40cDFTwYFCAF+HROyjLjtSuhm6vZ107r
	ZFK2980aMN6R/5c4GWwrJrvTMugHlMgjl3rmQQe5mI7I2b2etDuqBYlkjSrH1GP89wextSNk9f+
	A=
X-Received: by 2002:a05:6000:400f:b0:454:af3:33a0 with SMTP id ffacd0b85a97d-45b12443017mr4325458f8f.17.1778592558728;
        Tue, 12 May 2026 06:29:18 -0700 (PDT)
X-Received: by 2002:a05:6000:400f:b0:454:af3:33a0 with SMTP id ffacd0b85a97d-45b12443017mr4325399f8f.17.1778592558110;
        Tue, 12 May 2026 06:29:18 -0700 (PDT)
Received: from localhost (bl15-153-58.dsl.telepac.pt. [188.80.153.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4548e6a6a64sm34093892f8f.6.2026.05.12.06.29.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:29:17 -0700 (PDT)
From: Sergio Correia <scorreia@redhat.com>
To: audit@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: paul@paul-moore.com,
	eparis@redhat.com,
	rrobaina@redhat.com,
	Sergio Correia <scorreia@redhat.com>
Subject: [PATCH] audit: enforce AUDIT_LOCKED for AUDIT_TRIM and AUDIT_MAKE_EQUIV
Date: Tue, 12 May 2026 14:28:59 +0100
Message-ID: <20260512132859.1305499-1-scorreia@redhat.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: qy82qnVlBkxCIZZH5DgBFswPeI99IUsD6oWmnBvunAY_1778592559
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

AUDIT_ADD_RULE and AUDIT_DEL_RULE correctly check for AUDIT_LOCKED
and return -EPERM, but AUDIT_TRIM and AUDIT_MAKE_EQUIV do not. This
allows a process with CAP_AUDIT_CONTROL to modify directory tree
watches and equivalence mappings even when the audit configuration
has been locked, undermining the purpose of the lock.

Add AUDIT_LOCKED checks to both commands.

Reviewed-by: Ricardo Robaina <rrobaina@redhat.com>
Assisted-by: Claude:claude-opus-4-6
Signed-off-by: Sergio Correia <scorreia@redhat.com>
---
 kernel/audit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/audit.c b/kernel/audit.c
index e1d489bc2dff..34dc7cb246ff 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -1468,6 +1468,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		err = audit_list_rules_send(skb, seq);
 		break;
 	case AUDIT_TRIM:
+		if (audit_enabled == AUDIT_LOCKED)
+			return -EPERM;
 		audit_trim_trees();
 		audit_log_common_recv_msg(audit_context(), &ab,
 					  AUDIT_CONFIG_CHANGE);
@@ -1480,6 +1482,8 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh,
 		size_t msglen = data_len;
 		char *old, *new;
 
+		if (audit_enabled == AUDIT_LOCKED)
+			return -EPERM;
 		err = -EINVAL;
 		if (msglen < 2 * sizeof(u32))
 			break;
-- 
2.54.0

