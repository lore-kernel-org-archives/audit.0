Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900242D73A0
	for <audit@vger.kernel.org>; Wed, 29 Oct 2025 00:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761699298; cv=none; b=TrITyt7NCKUbfJsaMTgmcdE2uNV9ofqx3yejJ9q1GEilBXgE3rvPaG8xccPIdecpkgggcV1B4+pkjwm8t19oPQF+NfPda+jvoe3GDwMbj/q96hmGoBpBl40Co7wDREBAT/GIabPAWx0/pZKklGLhI0p/t2bxjiAlViYCA99rW64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761699298; c=relaxed/simple;
	bh=QfA6ueu2RM00VYhWG6lIl1KGnKoJGm124vSmauR90CU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HiLPTiJrTyo0+1MvHx2ML8vcL6kfex60q3dRb7rt74uW4y0zWAWS6gYUKjLLb8PppbQslqDHGRptfJvKXvE31F+aj4ZYBKMgAFjZJEyfKjr3ZGIoFxjT7PzKVLuZmwmtebRRToNrFR/z2Xt0Bi0i0VSyRe+vJOqIp1saXIAGq8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=y8Pj8FWM; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--isaacmanjarres.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="y8Pj8FWM"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-33bb3b235ebso13666053a91.1
        for <audit@vger.kernel.org>; Tue, 28 Oct 2025 17:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1761699296; x=1762304096; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=U0ZBDM2WqDs4+hrpz4i4EEV6LSR579hv8hvS+XN4X+4=;
        b=y8Pj8FWMwtGr9UkUjrOvzhYi/5k06miqC50pJVyMoEwSTCzhtSGbDgkuslCRWR+9Pz
         2JJpYwpEQgQz2OVcjwIIeqravmNlMZJtEw/3CbWJiG4u8NhHnNAjAlglat/Ye/j849Ww
         PQqjv9eEk1LiSuE0CGvZuB/iDSvmTuRO7OVlKm0To78R4r7vYc+M/uQFf2XKxhA/AOU8
         DAmh7wGfTuI+vJDGGpOy67JW4nqAmNpAymFzUrEjaZPMNGMS9zMk/9MW/D5ohaRegwoY
         HO1k1wamrSU4jLDqinvf0PW3FJCL+q/EgdLSDhHn3OGhjXHzU+tY8Y3j34VALtuXW+UF
         dQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761699296; x=1762304096;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U0ZBDM2WqDs4+hrpz4i4EEV6LSR579hv8hvS+XN4X+4=;
        b=sNURzAZ0YfQiSKH+w2E+oAOnr8jPFMXFgbyIgFknK5WXJZsXGECZ9gjU4ciruMLcNj
         9U+yMg7zaj0lussieG2IsRl3+0QRBRXgyuJ9hZnKMo9zuwr2dRfEMDFDszqeLjl46zfK
         Gib8DYID+DVLws1tpV+5kdg5VGNsqvsuYLrJjDpo9J8VZTEuddA2MVFJsWOK2TTYowV0
         MQTk9xZH7sbgUQcGxOzHP9HYCC6f1ey/BFf0opUNVAYzDdSvs5NM8V7zr7KT3IOAnhTj
         0/iyi17iJ2jPIaqFVQeIEwN6HYlsyirxg9kWdtE2P98K1zRzg9eKK+ODOpopRs/48kRt
         ibhg==
X-Forwarded-Encrypted: i=1; AJvYcCX1piSKNPFUn6ZwZXgzOP1F8OAJMLBOyVF6WBmmjzkmFhKPpwxfu7xl338/DKkMSG6G0GnLpA==@vger.kernel.org
X-Gm-Message-State: AOJu0YycrKELH8LkLZRcL1sT+jdiWNxFW8B/54fTYdG0CZvDZHHZ3Zb0
	SIBShc0QHfiUXaPCj4n1MeeQIJyfHqXk+JRaqm+uqFI3QXuswyNkkM0dvntcnnyTPuf/GZZN+dn
	R+kYOy3n2N/kx3sJOorqHj9AC66rH5nx20X37FQ==
X-Google-Smtp-Source: AGHT+IGjiXMadbpYiil9Vmkl6RnYWU3TmKaYZ7ofRAVV/o5scIk3NiDBTPH+cBn/nEjZom/bXwEj4x59awX7jYcm5CW3iA==
X-Received: from pjbpb12.prod.google.com ([2002:a17:90b:3c0c:b0:33b:ba24:b207])
 (user=isaacmanjarres job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:5404:b0:339:a243:e96d with SMTP id 98e67ed59e1d1-3403a2a22f9mr1156419a91.36.1761699295688;
 Tue, 28 Oct 2025 17:54:55 -0700 (PDT)
Date: Tue, 28 Oct 2025 17:54:47 -0700
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.1.851.g4ebd6896fd-goog
Message-ID: <20251029005448.495880-1-isaacmanjarres@google.com>
Subject: [PATCH v1] audit: Improve path logging for unlinked files
From: "Isaac J. Manjarres" <isaacmanjarres@google.com>
To: Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>
Cc: surenb@google.com, aliceryhl@google.com, tweek@google.com, 
	"Isaac J. Manjarres" <isaacmanjarres@google.com>, kernel-team@android.com, audit@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When logging the path associated with a denial, the path is scanned
to ensure that it does not contain control characters, unprintable
characters, double quote marks, or spaces. If it does, the hexadecimal
representation of the path is emitted.

This can make debugging difficult in scenarios where the file name that
was given to the file does not contain any of those characters,
but the hexadecimal representation of the path is still emitted when a
denial occurs because the file is unlinked.

For example, suppose a memfd is created with the name "MemoryHeapBase".
Memfds are unlinked, so when a denial related to that memfd is
encountered, and the the path name for it is obtained via d_path(), the
name will be: "/memfd:MemoryHeapBase (deleted)". Since the name has a
space, the audit logic will just print the hexadecimal representation
instead of the name:

type=1400 audit(0.0:319): avc:  denied  { read write } for
path=2F6D656D66643A4D656D6F72794865617042617365202864656C6574656429
dev="tmpfs" ino=75 scontext=u:r:audioserver:s0
tcontext=u:object_r:system_server:s0 tclass=memfd_file permissive=0

To improve debuggability of denials related to unlinked files, check
if the " (deleted)" suffix is detected in a path name and remove it
if so. This allows the actual filename to be validated and emitted
if appropriate, making denials easier to read and more actionable:

type=1400 audit(0.0:254): avc:  denied  { read write } for
path="/memfd:MemoryHeapBase" dev="tmpfs" ino=67
scontext=u:r:audioserver:s0 tcontext=u:object_r:system_server:s0
tclass=memfd_file permissive=0

Signed-off-by: Isaac J. Manjarres <isaacmanjarres@google.com>
---
 kernel/audit.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/audit.c b/kernel/audit.c
index 26a332ffb1b8..dcfa60e0277d 100644
--- a/kernel/audit.c
+++ b/kernel/audit.c
@@ -2184,7 +2184,7 @@ void audit_log_untrustedstring(struct audit_buffer *ab, const char *string)
 void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
 		      const struct path *path)
 {
-	char *p, *pathname;
+	char *p, *pathname, *suffix;
 
 	if (prefix)
 		audit_log_format(ab, "%s", prefix);
@@ -2199,8 +2199,20 @@ void audit_log_d_path(struct audit_buffer *ab, const char *prefix,
 	if (IS_ERR(p)) { /* Should never happen since we send PATH_MAX */
 		/* FIXME: can we save some information here? */
 		audit_log_format(ab, "\"<too_long>\"");
-	} else
+	} else {
+		/*
+		 * Terminate the buffer where the " (deleted)" suffix starts so
+		 * that audit_log_untrustedstring() emits the pathname,
+		 * assuming it doesn't have other control characters or spaces.
+		 */
+		suffix = strstr(p, " (deleted)");
+		/* Ensure the string ends with the " (deleted)" suffix. */
+		if (suffix &&
+		    ((p + strlen(p) - strlen(" (deleted)")) == suffix))
+			*suffix = '\0';
+
 		audit_log_untrustedstring(ab, p);
+	}
 	kfree(pathname);
 }
 
-- 
2.51.1.851.g4ebd6896fd-goog

