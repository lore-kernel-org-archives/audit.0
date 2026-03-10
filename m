Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC94239E63
	for <audit@vger.kernel.org>; Tue, 10 Mar 2026 19:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773170373; cv=pass; b=uWz4aqqQo1EZPBJ6PVVVU0Uc/o+vI6UX3hGuOfVv9vZL7zZ2m0pFA8NqYyA/qjhkpLyf2elaEePpPDupHaVZ/ivSh3XNmuUjvrCFVLIMyN4LFsIZxBSprI55HOAeCmCojnGEzaT5Et7WNkSAiYhtRKXIhbUI/M/88jTbWA93kBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773170373; c=relaxed/simple;
	bh=xjkcSNQCQn/Kf6yUVnGVm/L7Q6zp2zQuck405QLyILk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fZ82uKO10Cfv/jV/FHBW9hZlaIUvJrK0NUMhw1KiLqsCbkxUiqA7efOT7pAExEEeLYeSZKOwQntBSPdDn02rv2WpWgW13jrygm33oRUIie3aBUG70oEsj17KvP6CjWVWoWWDdLSiTtzmxc28OaSaR+PajUJQmlTPCsLEeRZnaUI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=CUDXdF8L; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="CUDXdF8L"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3598df39444so6276970a91.2
        for <audit@vger.kernel.org>; Tue, 10 Mar 2026 12:19:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773170372; cv=none;
        d=google.com; s=arc-20240605;
        b=RR6EZJpumaEZM7Z457ZGQYtJ8dcdtiLFkFQjIeYsGFiLCpwwWx5Mgur++7555PckH/
         hs+1nI/7LlA9v0ArdEPu2V5ZMn7H9gSxg7htyMBBNBW8NSBCzkqCp0BhIIyeby4ZJxtT
         6GHPs7JE4sK20f2P7um23wa17JjEGIedBtgVdsYD4E4HhkTYmTT8D4lYIl8XpwesLu1a
         wWTpQ5B+wc7pvF4dcbl0mH+G7KyktjSwu0PP5WiYts7TO4rDaU9l2TfCskJwphAQ44pL
         B0mayZLfSwBUOBSXdY0MAW4gli/dlhtNF1X3gD0Cfuk/PhPxllrygi7pD1VyEllwy/d3
         VRcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=U6VxqmfQaZseJJ7vR2X1vkl0eCDrvXHEkhTypy0Kl1g=;
        fh=96LMm8YveidslPMv7BwLxRS4IrqVTCapoHQHkWYyhu4=;
        b=EIYtfSFWnIxekwOQ3Vvc+CENohvDmVZRpoOuuLLq+sELbJkaeciS7V2FeV1tlWtVDh
         7vMWaTgw9PUIEFAIA/vPRBSFBnaOGbqTsYMKhqcJJb0CTOpkkas59gUWorc9ChTBedRS
         xXGG34/Af3XNop/UE/d2npt32JSp0Xt6j9Hgpng8yek1CQ9zDX7nx5sOckX1qdILeXFb
         1OULufDk0b5Nh8KMDKlG3HPNfxdZvWRoLTlOs7FR49LLmgF/BygTGt3T8VF0hcYe7bUE
         11++BylULiYh5AiRbTDwBuxpQ9k+oPNF3yHKDhLL599UvausaDZ9kTaofbnof8tik7jO
         K6hw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1773170372; x=1773775172; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6VxqmfQaZseJJ7vR2X1vkl0eCDrvXHEkhTypy0Kl1g=;
        b=CUDXdF8LllpcvPfLNjdrzFMqSD8a78ZIe8SSXyqcHX8LXI/PvwyjVm3XuLfleAJlG9
         lOfTqNoWEKcJuItuRTL3gQOgRlo5EZx1wdY9Ld72/vHtWndomj7scBayai7dbWT0tV+a
         FWzRO35z6zseTQs9bYW47aPLhiEVP2TV6gvbCjl4ofLklCFbegBKZlsP1xXu6bL0rurA
         UzAvLdZgsNN6946vcLMU2gGOIu4W/ago/yJV+ZLPDIRqG2e9DczWim8GK1Skzridezyu
         NzQS5hO1jr2wEGxbf/d8aHa7jKoG2ke/NkMs4HIRDxg322hZU9zgevDIxRPqI0RTtgcR
         7KxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773170372; x=1773775172;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=U6VxqmfQaZseJJ7vR2X1vkl0eCDrvXHEkhTypy0Kl1g=;
        b=G246+4dKMThiAk++pNNdip0NetydKzYTV4e0rIwbPj5T/F7/ANKCm53QxacKOg1Edp
         fWf0O3EVqAt2AHut5WfyBb4r9skp4XHAiv5/4GTnlyMKL8iYQC/Puz9stspmhOERmrun
         gyeoxqYlxbCfdIVPdrmninX0e9hKx2+Gg7lhtNQNpldpl4HIaqOLEx2vBMNnDBHzKpfx
         MwcQBV43ZGZd18PlxCC3zLKrv6Y9ohqxsyRAYlhUpo91q+4bjNccaEc2PArV9Y7f+WwV
         fk4nVqRkzIMMFxlYtaMB/VRiGk7nXPc18XO8VCKOt5UuEtxjjivRhbpruq1Mmgj7rh8D
         Dm6A==
X-Forwarded-Encrypted: i=1; AJvYcCXKLmlS142hnyrz09tVDb+60aajhrlrNDogDgeg0UJwM6VZ2rsMrYDW3EGO69/VhEY8JpxsnA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2B8T7clyxK30+Gr97khTgnEyL4Z2rtUej9V16hCM2mAmJV5FX
	VaKJ4XtbWHkv8nDXX22qdG6hpVBka8azCvFTN7QueKubb10226TrZQASBP2RRRPtLEUo1jXgFLq
	OVwREcLod4f47oXvtv9ZKO4TnOF79GLhM5SekhRsh
X-Gm-Gg: ATEYQzyt4Bgz7PhTXQSkc/Kw9Mo5EY43Z/Zsvs9vxeSiJ8de7fUf3IVGVI2BqEjmPBU
	CiqC1bc4o/o9gW2y8HrtXGmUTJyYFMGJLZsZSA3SsKMvmIwaXM9MV1NZs9csMLgRVIc6/V59axR
	kIchXkJ26Lk7EKJI4FDlkhA8CYrDJmFf7wmYzRCEoEHw7nVP5RcqkwKkg8QsTxx+pRQ1EAlqxzQ
	SjOcKHZX9nhkjRYCqTC+VeQ+AjnscxAgYC0jiUwu5Cs6InOdLWrT6rNVD+EaZj+6had4CR0wqjK
	9x4jgAQ=
X-Received: by 2002:a17:90b:3506:b0:359:87ff:f352 with SMTP id
 98e67ed59e1d1-35a01202655mr59010a91.8.1773170371992; Tue, 10 Mar 2026
 12:19:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
In-Reply-To: <261b1be5b8dc526b83d73e8281e682a73536ea28.1773155031.git.chleroy@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Tue, 10 Mar 2026 15:19:19 -0400
X-Gm-Features: AaiRm53eSE5v3aP0W_oG_AsIWqYfzaIoe1cP2U70PYN3EqAi5OekgDYF-nWk5uw
Message-ID: <CAHC9VhTyOuuPs1uovodM9M_8zZeJnVXs9xrWSdPhZcjXUb=mvA@mail.gmail.com>
Subject: Re: [PATCH v3] powerpc/audit: Convert powerpc to AUDIT_ARCH_COMPAT_GENERIC
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Eric Paris <eparis@redhat.com>, 
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	audit@vger.kernel.org, Thomas Weissschuh <thomas.weissschuh@linutronix.de>, 
	=?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 10, 2026 at 11:08=E2=80=AFAM Christophe Leroy (CS GROUP)
<chleroy@kernel.org> wrote:
>
> From: Christophe Leroy <christophe.leroy@csgroup.eu>
>
> Commit e65e1fc2d24b ("[PATCH] syscall class hookup for all normal
> targets") added generic support for AUDIT but that didn't include
> support for bi-arch like powerpc.
>
> Commit 4b58841149dc ("audit: Add generic compat syscall support")
> added generic support for bi-arch.
>
> Convert powerpc to that bi-arch generic audit support.
>
> With this change generated text is similar.
>
> Thomas has confirmed that the previously failing filter_exclude/test
> is now successful both without and with this patch, see [1]
>
> [1] https://lore.kernel.org/all/20260306115350-ef265661-6d6b-4043-9bd0-8e=
6b437d0d67@linutronix.de/
>
> Link: https://github.com/linuxppc/issues/issues/412
> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
> Venkat, a test result with https://github.com/linux-audit/audit-testsuite=
 would be appreciated.

Yes, I'd like to see confirmation that the audit test suite runs clean
on ppc systems with this patch applied, and unfortunately without a
ppc system I have no way to test this myself.

> v3: Rebased on v7.0-rc1
>
> v2: https://lore.kernel.org/all/a4b3951d1191d4183d92a07a6097566bde60d00a.=
1629812058.git.christophe.leroy@csgroup.eu/
> ---
>  arch/powerpc/Kconfig                |  5 +-
>  arch/powerpc/include/asm/unistd32.h |  7 +++
>  arch/powerpc/kernel/Makefile        |  3 -
>  arch/powerpc/kernel/audit.c         | 87 -----------------------------
>  arch/powerpc/kernel/compat_audit.c  | 49 ----------------
>  5 files changed, 8 insertions(+), 143 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/unistd32.h
>  delete mode 100644 arch/powerpc/kernel/audit.c
>  delete mode 100644 arch/powerpc/kernel/compat_audit.c

--=20
paul-moore.com
