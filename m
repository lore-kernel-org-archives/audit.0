Received: from smtpout42.security-mail.net (smtpout42.security-mail.net [85.31.212.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C7D16CD22
	for <audit@vger.kernel.org>; Mon, 22 Jul 2024 09:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.31.212.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721641506; cv=none; b=pqUEdbzvn0UesQfFIAxVJIB9XLp7Dd2aUizWKhVtGsoec5VmpGi7NsST0o9NeuA2vGMK0cGED21FO8NTqkBQjWc5cMpA3uZJ7Wibx+BbTipAyr9xGLHFXyl7D6GOztv+CbPWWO7uh3+4r/DBqwMzHCeEvln3HCoF2I1zyWmxGP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721641506; c=relaxed/simple;
	bh=hBw3JMQA4zvpLtBy+6/1m/DQmJRkpxpnzq6/ZBHGrP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A51d5iv3hPnrxLzYn8UatgwNLDogmZGOjmUI93dJaGTPpBbliXZ14jvwDOaGVrWgu/AK/q/O8qLQPiHOH64S5PoZqUcxvIBhresTY1/7OQ06DQyXNKHsp679TxZHxeJqe0SfUAI/+7FeFy/Qqhr+CW2JCzix9lGPiisG4Q0BQ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com; spf=pass smtp.mailfrom=kalrayinc.com; dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b=WmV+DRpn; arc=none smtp.client-ip=85.31.212.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kalrayinc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=kalrayinc.com header.i=@kalrayinc.com header.b="WmV+DRpn"
Received: from localhost (localhost [127.0.0.1])
	by fx302.security-mail.net (Postfix) with ESMTP id A6D0380A874
	for <audit@vger.kernel.org>; Mon, 22 Jul 2024 11:43:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalrayinc.com;
	s=sec-sig-email; t=1721641402;
	bh=hBw3JMQA4zvpLtBy+6/1m/DQmJRkpxpnzq6/ZBHGrP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WmV+DRpnUUOg4D08q68w+Zh2MkHRv7p9UonTFtjGxBx4hag6W6dYFg3qLgKlMhWdL
	 2EGHbIwC1gpCDOjAyjaYWD8S59qy/HRhqRQ9DoSznovl1Pir7MmljvWDMa2vwEAlXH
	 7FkihZUcutlHxGVeXQBOVMH+lV2ZC1AdXB8n0mjc=
Received: from fx302 (localhost [127.0.0.1]) by fx302.security-mail.net
 (Postfix) with ESMTP id 7F0E280AFDB; Mon, 22 Jul 2024 11:43:22 +0200 (CEST)
Received: from srvsmtp.lin.mbt.kalray.eu (unknown [217.181.231.53]) by
 fx302.security-mail.net (Postfix) with ESMTPS id 6319480AE53; Mon, 22 Jul
 2024 11:43:20 +0200 (CEST)
Received: from junon.lan.kalrayinc.com (unknown [192.168.37.161]) by
 srvsmtp.lin.mbt.kalray.eu (Postfix) with ESMTPS id 2F44740317; Mon, 22 Jul
 2024 11:43:20 +0200 (CEST)
X-Secumail-id: <ae72.669e29b8.619e8.0>
From: ysionneau@kalrayinc.com
To: linux-kernel@vger.kernel.org, Paul Moore <paul@paul-moore.com>, Eric
 Paris <eparis@redhat.com>, Eric Biederman <ebiederm@xmission.com>, Kees Cook
 <kees@kernel.org>
Cc: Jonathan Borne <jborne@kalrayinc.com>, Julian Vetter
 <jvetter@kalrayinc.com>, Yann Sionneau <ysionneau@kalrayinc.com>, Clement
 Leger <clement@clement-leger.fr>, audit@vger.kernel.org, linux-mm@kvack.org
Subject: [RFC PATCH v3 12/37] kvx: Add ELF-related definitions
Date: Mon, 22 Jul 2024 11:41:23 +0200
Message-ID: <20240722094226.21602-13-ysionneau@kalrayinc.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240722094226.21602-1-ysionneau@kalrayinc.com>
References: <20240722094226.21602-1-ysionneau@kalrayinc.com>
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
X-ALTERMIMEV2_out: done

From: Yann Sionneau <ysionneau@kalrayinc.com>

Add ELF-related definitions for kvx, including: EM_KVX, AUDIT_ARCH_KVX
and NT_KVX_TCA.

Co-developed-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Clement Leger <clement@clement-leger.fr>
Signed-off-by: Yann Sionneau <ysionneau@kalrayinc.com>
---

Notes:

V2 -> V3: update NT_KVX_TCA register set number macro
---
 include/uapi/linux/audit.h  | 1 +
 include/uapi/linux/elf-em.h | 1 +
 include/uapi/linux/elf.h    | 1 +
 3 files changed, 3 insertions(+)

diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
index d676ed2b246ec..4db7aa3f84c70 100644
--- a/include/uapi/linux/audit.h
+++ b/include/uapi/linux/audit.h
@@ -402,6 +402,7 @@ enum {
 #define AUDIT_ARCH_HEXAGON	(EM_HEXAGON)
 #define AUDIT_ARCH_I386		(EM_386|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_IA64		(EM_IA_64|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
+#define AUDIT_ARCH_KVX		(EM_KVX|__AUDIT_ARCH_64BIT|__AUDIT_ARCH_LE)
 #define AUDIT_ARCH_M32R		(EM_M32R)
 #define AUDIT_ARCH_M68K		(EM_68K)
 #define AUDIT_ARCH_MICROBLAZE	(EM_MICROBLAZE)
diff --git a/include/uapi/linux/elf-em.h b/include/uapi/linux/elf-em.h
index ef38c2bc5ab7a..9cc348be7f860 100644
--- a/include/uapi/linux/elf-em.h
+++ b/include/uapi/linux/elf-em.h
@@ -51,6 +51,7 @@
 #define EM_RISCV	243	/* RISC-V */
 #define EM_BPF		247	/* Linux BPF - in-kernel virtual machine */
 #define EM_CSKY		252	/* C-SKY */
+#define EM_KVX		256	/* Kalray VLIW Architecture */
 #define EM_LOONGARCH	258	/* LoongArch */
 #define EM_FRV		0x5441	/* Fujitsu FR-V */
 
diff --git a/include/uapi/linux/elf.h b/include/uapi/linux/elf.h
index b54b313bcf073..2d4885f2e4995 100644
--- a/include/uapi/linux/elf.h
+++ b/include/uapi/linux/elf.h
@@ -448,6 +448,7 @@ typedef struct elf64_shdr {
 #define NT_MIPS_MSA	0x802		/* MIPS SIMD registers */
 #define NT_RISCV_CSR	0x900		/* RISC-V Control and Status Registers */
 #define NT_RISCV_VECTOR	0x901		/* RISC-V vector registers */
+#define NT_KVX_TCA		0x902	/* kvx TCA registers */
 #define NT_LOONGARCH_CPUCFG	0xa00	/* LoongArch CPU config registers */
 #define NT_LOONGARCH_CSR	0xa01	/* LoongArch control and status registers */
 #define NT_LOONGARCH_LSX	0xa02	/* LoongArch Loongson SIMD Extension registers */
-- 
2.45.2





