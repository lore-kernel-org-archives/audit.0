Received: from sonic303-28.consmr.mail.ne1.yahoo.com (sonic303-28.consmr.mail.ne1.yahoo.com [66.163.188.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8716F33E4
	for <audit@vger.kernel.org>; Sat,  7 Jun 2025 01:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.163.188.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749258111; cv=none; b=OnSjd18WS68hdS4Kerbpx8FXCh2xzJ85mmqU/sMpHl9dFOsvOwIKuxqioTetKYdZsCW0vnzSL8tUBX5x4DLYFZmlYV2yEUOE+Hxb04nfZfWOp6p3ak1NXa3Fv5wVVTsCI1zInQWM43SzTDd0T+2MAodrrLR2wdBaCytQ224HI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749258111; c=relaxed/simple;
	bh=35O3bnvh5n4X7Z+GZimBknXeddsK3bvrowCSOAosKEQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=EwGE+Zkj31cNs/rxHPRnwIxcPjoi2Grek9dbb/HaOuktcpY/xYWw3dDUSsU7znt7Jh5j1a+ZlAThXyI2+z8ZjEKDWIinYUY9/v3aYz9cmNNCwjcbYUWvyUPjTG0fb08IqdTq6EduzvJaZOWbe1IwHPr4r6YOCWj5k5n47uL6tQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com; spf=none smtp.mailfrom=schaufler-ca.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=K/doo6/y; arc=none smtp.client-ip=66.163.188.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=schaufler-ca.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="K/doo6/y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749258108; bh=HwtOuxPXkaV/TM2242shxO68DjffLsvsEmfEB27DYkg=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=K/doo6/yu/v+jVq4fNi6dp3P1uABIV8xld8xNTA6EK8vIeMn5bcmJJ9kd3Y1zigagIsiZ7kg21nrT36L2vZzvV1AW9lzFnusTjkarMyiU9GZX5mN2+U+N9+2n1Vu0wCtJwsUgPHnysJ3KpgCEyzVKLyvxdtohEwwqwsXAtTC+82n06GQh636mxI7DIEiaRKoNugIFiwOJ5IYfrLthQqZICWYxvUAUjmpuElUujOsI0HwiqGas1CLosxbTBnIfOaF5ia56W7jhF6NTWQtxeCHvnzb4ZaQP7Mg2O5jtaszovmEWLDVUpbkYRQ2sFRvDkps8saFywAozrPU79anqljiEw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1749258108; bh=DdUEqninbXxnl43O7VBkA7G1oaMZrHMHGNDbCnxqbJQ=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=l8ST4XiFFV9fHShmQvuaYxSXNpccVO309V/+mQaxO8+6wnS7iajvUjht104U5SX7g+i0rQCtY99CSeRbQwOqpFVQh0w23ExLSsBGcPk2igcsIWHYFPV96SDZaBDjJVfpWun/H1k4ln9cBvll0gqDi4QuNR1HyvQkj3lt5tEV1LLQmzpa7qJCdPIXommGSk3h4QvWlPPYjDECgTgYpGDYkUtBAKk3lgh00JpNgk5uEKxBmhNtqPR/VBla7h9rE2UGs+GM0Bgqk4gIPeIpMaiTl7hnDWghZKMq4MgqeU1+z3G8ZiTAymPeyUNZWyFvmr+pI5mjLSp9kHir3aD9pYfaAA==
X-YMail-OSG: t_GdkHkVM1kSZv1FgANrhhX_HY_7cbs5uXKukcJ4EqkZpoTjNGSJMwiqKNSOeWP
 kIr6ZaNO8f6.cWpG6Aa0Q4QiNashurIEunM3I1D4d0zlzeGoGhxgDY4ndRvla_Spl7jcwaaEPh2O
 bBFfdSssZGswB3KL7_NCV8iBHFslewHvTsI0OkbKQTyU06nV4WYBpM1wM9mJvBhdGAxEorgIZ2WC
 _xVboA2IKU7JLSwEzAZ2z1KsVp.RvzwvjOmGpVHkbuJmjeCpDQ0fWkevSICOf7VqbdL3N7k0lrHu
 Uk6z3Q.eWqioqiP.mojswzZdqYgHLWz2NAKNjLCp_8CPvGwduqvVU7vzoVbQ_iGcHAf.PL7pWJ_3
 WOB5rX.kENeu5fkim7zgMO03ocneyfIh9c4mEVgMIPM0IL4oaWJ0WvRRT3NWztgvmZZ3I.d80vDd
 02cxXT8UsKRpBBmQvAiDJrngbCrHDh3E0uTinfU7NnxHlYr1I6P1Hi_gbvDbP8DANINy4wFulCe1
 pYQQ1JJa9AUeftFUJRLu4kUhw_Lmow5quq38m0iFQNlIOQmkvUh42rZjZnhkoEEU4mGvNMSi8OmQ
 Hj70CX7gwwUyudmlUeEi3v4xi.qp1ji0JE9XDuvBNISlFsic_oSvcx5MvjY_cKG8qsLYwYBZJ8BO
 UkODPJ3JoqmEiItBLTcGgF1OPK7viW3rvrSAvmD8EfEe10H1ioiXs2wMN6q3kqD7skwLR6ZbijMD
 6g8kDnwGoSkj2qx37r.SSC.H0Gamn4Ry4euioM908q7U8UsnzAuEKJ12pkL81mFIAn7TalZqZnvU
 GgE36EJfE0BFkXOhSd52Yc2D6ftSvXBCCfMkmRrtZgyuiYlXVOdA81_RmOGDw4DI_LJJCW4pvVHF
 3iVsVb6nclL1PijKA17dLaDT7Z8mqr.CArWS0bCG7esQAY9vndXak.nRP1J2P7i1W7maZdJ6j5He
 7FT_cY8ohPaYTqxk6amH9p93E6uAHwP9J2F_QrwqRjN3jXSwwX7eUNArpr92rV0W79xraWLBuoHR
 LlehxRN9NW_tDdaQhGtnXO6H__zVtop_xocxyN29S0e4V12mffqr_.rX3SZAszZbi2BTr92I6C.2
 koSKasyYygAD25BCZmftBz0E6jc1H1x2JodIoY4l19afOjr0yqJu_aOM4bIkngozQkv2c5KJv8au
 5gahevqdAv0VinphxVN6rlGyQz7KbLFuwReadbqPs3tv5LoTFBFMA8KvlypTipD1RjA8mkG7_oQg
 ANupQFV2qR9ng57sc97kIwsIrCNPTgN8z8Qh9ToKbqBi2wd2YHJXmj4asPJ9BrJ8blUxroi33kPv
 zPR8HmJL2l6wpgIPwyAt7.oYS8s.I3ZqiDXbja_spdwWyRwYociZPBMUbz6Bul9tloNCDKqtaeVQ
 P9ZO20d9X6aYtfOr9PSw1wGxstjWYUcpMcjDgzHEKTaDDiinJ1zHhUS4KSvcLqIXhku3PiTrXDzD
 sZjEap_84mvRw5sdqzh.1MxRxn6lWliLNXKpj.1mvMJW9sW7sibrkMffpSeGtrK2TTAA6HtQzhuF
 o7yGhm_QnhEpJ6_BKb.GY4UyNbAUBaJDrWRoZmT3.SR6YVlfXQIy5P_V_18ftuyLA_k0qDcJV8W7
 No1e1_nGXE7Xu.H7eA51D94Vdxj1MtVTR243w7NsWWrNFPFy8tksAvZKTZH_fmcaJ5Avj8k24Q4j
 wdyzAPFCX9IQJu2nHU40a3NHMPcxvpGZKlUWuay27Hi4JLF1aIHx3ZmQB67Wl56BtPc94e2e63eY
 UZefpl9bgxy.ktAGEjb79.QS_JDYu7tdUuDTjvUs76bLrdM4mbAo4kgb55DIoWdS.2kbaZYoksi1
 xnGEoTxnfFps_aFespY.dteVjSRoRZhS97Yl2tWE9ImH4a_XZrKLijnze.XHvgK36a2E.Mz3bnom
 JptF5ImsLwJpj0FGtO1zieaoRT7RuvEwwrkPH8ATtigNpzJtZYEF5GrNBOA4yvATx6KSl0B7uuIR
 SB.EajGU_x5sIv68v28raJhwd2PZsZP.MXk9oeF6fft668ripdf9SvzmP75P3yREZhzFjCNvaGYQ
 _4GHFCN4fJSRmcSSLB7ZbWg4OeP79v0f9VIi0Dq0k.WjUm0hz7fZRd4kxwHLk1RpZt2dxDac5I61
 TPJtsnxsySds4nX_qN.DLrLbUJH0fHGuEXMtLxvUAJLO1I7OJu0WgnKBMx2v.lIU3MHFeEmlR_bk
 SkK_HyPGvfRCwZWMEtRWZTa5Jf9VM0SSz4TYe9n8d7.Qu2YH6EO.FEKmXyXlbUArdZHvbDYf2QNj
 8VhIdluHQPSlJvCyH8rEteWQ-
X-Sonic-MF: <casey@schaufler-ca.com>
X-Sonic-ID: b9ab1a19-93bb-4016-adc2-9fecbd8da5fb
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ne1.yahoo.com with HTTP; Sat, 7 Jun 2025 01:01:48 +0000
Received: by hermes--production-gq1-74d64bb7d7-5qmwx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7461f2feac0d1a8decd03521522bae75;
          Sat, 07 Jun 2025 00:51:38 +0000 (UTC)
From: Casey Schaufler <casey@schaufler-ca.com>
To: casey@schaufler-ca.com,
	paul@paul-moore.com,
	eparis@redhat.com,
	linux-security-module@vger.kernel.org,
	audit@vger.kernel.org
Cc: jmorris@namei.org,
	serge@hallyn.com,
	keescook@chromium.org,
	john.johansen@canonical.com,
	penguin-kernel@i-love.sakura.ne.jp,
	stephen.smalley.work@gmail.com,
	linux-kernel@vger.kernel.org,
	selinux@vger.kernel.org
Subject: [PATCH v4 0/4] Audit: Records for multiple security contexts
Date: Fri,  6 Jun 2025 17:51:30 -0700
Message-ID: <20250607005134.10488-1-casey@schaufler-ca.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20250607005134.10488-1-casey.ref@schaufler-ca.com>

The Linux audit system includes LSM based security "context" information
in its events. Historically, only one LSM that uses security contexts can
be active on a system. One of the few obsticles to allowing multiple LSM
support is the inability to report more than one security context in an
audit event. This patchset provides a mechanism to provide supplimental
records containing more than one security context for subjects and
objects.

The mechanism for reporting multiple security contexts inspired
considerable discussion. It would have been possible to add multiple
contexts to existing records using sophisticated formatting. This would
have significant backward compatibility issues, and require additional
parsing in user space code. Adding new records for an event that contain
the contexts is more in keeping with the way audit events have been
constructed in the past.

Only audit events associated with system calls have required multiple
records prior to this. Mechanism has been added allowing any event
to be composed of multiple records. This should make it easier to
add information to existing audit events without breaking backward
compatability.

v4:
Use LSM_ID_UNDEF when checking for valid LSM IDs in
security_lsmprop_to_secctx().
Fix the object record to include only those for LSMs that use them.
Squash the two patches dealing with subject contexts.
Base the patches on Paul Moore's LSM initialization patchset.
https://lore.kernel.org/all/20250409185019.238841-31-paul@paul-moore.com/
v3:
Rework how security modules identify that they provide security
contexts to the audit system. Maintain a list within the audit
system of the security modules that provide security contexts.
Revert the separate counts of subject and object contexts.
v2:
Maintain separate counts for LSMs using subject contexts and object
contexts. AppArmor uses the former but not the latter.
Correct error handling in object record creation.

https://github.com/cschaufler/lsm-stacking#audit-6.14-rc1-v4

Casey Schaufler (4):
  Audit: Create audit_stamp structure
  LSM: security_lsmblob_to_secctx module selection
  Audit: Add record for multiple task security contexts
  Audit: Add record for multiple object contexts

 include/linux/audit.h        |  23 +++
 include/linux/security.h     |   6 +-
 include/uapi/linux/audit.h   |   2 +
 kernel/audit.c               | 274 ++++++++++++++++++++++++++++++-----
 kernel/audit.h               |  13 +-
 kernel/auditsc.c             |  65 +++------
 net/netlabel/netlabel_user.c |   8 +-
 security/apparmor/lsm.c      |   3 +
 security/lsm.h               |   4 -
 security/lsm_init.c          |   5 -
 security/security.c          |  16 +-
 security/selinux/hooks.c     |   4 +
 security/smack/smack_lsm.c   |   4 +
 13 files changed, 318 insertions(+), 109 deletions(-)

-- 
2.47.0

