Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0443922425B
	for <audit@vger.kernel.org>; Mon, 11 Aug 2025 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754951005; cv=none; b=K52gRXFpWACoSWCSdc3McGBlTePJ2zQfohz6V7uTjqqRK25mtvv7FY14HTfqL0vUZb66Y5eoiOpr03f/YCrDuZTBJXvOcltOeK5vANkWbH+BStA6p7GTXoXu1ZxuplwVj7Qw/iT1BUnJDu/fuG4gT/5MUzPrvcK0PwCwgGEkaoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754951005; c=relaxed/simple;
	bh=UkjdFhfkD/5MPGo9lrvJIpAtslR7NzBNQeU9GjEIVS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o8bCRZj3HeYIoSNDGmuDuT4wFF56eCmRn3oKHUHhjmY2el1o2ag20oaKasD9yacdsIf1sLn1s/PqwwDF72gbYmtyQjqt383gegpsh5C9VFkBK5kEb5f3VS4UKD+llqolK4zw0oYevFonW/CFs28XNyIoMQ3Jq26tlpkfpjq3syE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=VQmJ9bwJ; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="VQmJ9bwJ"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-24099fade34so35068335ad.0
        for <audit@vger.kernel.org>; Mon, 11 Aug 2025 15:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1754951003; x=1755555803; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BqRVwbRElxBdPXk8lHsckCVjfIRqkrurOlwpMKEN7BE=;
        b=VQmJ9bwJjq7NqmL65iNeFkBh+Ge9NCFhKyWZftypmXP+/uAHG7wQm/Zgf6FMKYZS+z
         +tTMy9gQLYG0PnpKM7PVHR53L2E4L0Gd19THj1TyLej+OoteZXFT5PnJB1o11MSUN//b
         YgQAvGypyDjdlH2JwcZpita+BDoyBG4siomr9xQnyN90PL2aGnQxGqe9HUO0C0mBJ9Cq
         tGVOzW/risvTcO3fROub+p7EULiCTtv8dxBOy/AP+H1yBRSaYsZ1y/IysT1MmTtx/SWJ
         RVq80ogNIMh5xCAbvljTyJNvU8YT+9XzmyOkdvFa/e+86b8TCohnJR6dwhqK+UA/xqUf
         zTtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754951003; x=1755555803;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BqRVwbRElxBdPXk8lHsckCVjfIRqkrurOlwpMKEN7BE=;
        b=DhqWHMH4pArMPCphjYmqfcI5Z46bJARrIsgZREvBsbyomYubF+ig1Nu7o+/Y8eHpuU
         C7K23yIRo7KHyv3oo0khmbr8Dih7hbeLYLqsacfR6B8gIxgpoTevC05toPpG5SMm3whQ
         4UzLpRQTz6ClyLLOtQUoizu/sGMfz2pjMnaKaLglIwfMHkPg+JZZGps1t++HzdNKwdhe
         R68WP5Dn1fC2pXU+bgmm5emH2gExutdqX9QcAjfwLC5dURHMUFzm3m3pZbbup9Uwv47A
         X6EzhBA5Hwx/EF+j+C71/Bo3tpJy3KbYOMsR6QE5H9oRyc8vLh5O2PkNLMoZ+IAHy4WC
         DT6w==
X-Forwarded-Encrypted: i=1; AJvYcCVyIw7d4OI9PUwAqKh+EMcrkhV/IowpCnyybubX9IZ5cp7yKgrvxY62tfBl3L1VTgDjXYIUCQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7pLQb8ruWRslvWez6Vl1r1g1n6Z7/9a2Mt8WRDRNu5n+KGbqJ
	mGwL2P1j0mBSWZFuFTqLc1efeCs21eKPbWT9ZmzV608oUAegZ74SSQTluXcgWL+4WufVpc8xZfT
	8MvnTfRNEr/0rPHnnivSrkVgE1BeoX92eu5JMxw//
X-Gm-Gg: ASbGncsRrt6JLsr+FrgaHOXYRlQnoSFcrW65QKeVVJuCVSpuNmRDRAew8sSYIsULd5M
	YZWjfTlrSOr1z3F9QNXRImMdg8hUpiofysPw5+v7kisjaNdmX8/6WftFfY9CoM6bHUfiguMW3AT
	bjjI9g7wqKutNAbTtg4N+8CB7YHBDwm+fk9mCiT5D3hZpV9c8ode2V7q7Ney0wT5gwt7BfRMVOS
	9h3tAw=
X-Google-Smtp-Source: AGHT+IGOFn6nK9TXlaa8CkF00jvK01f6MUwhUi89/qVrrGCFQDmatsrEWgtc5jXmtyHYczNSCnTUlh5awjVGJA2HI2M=
X-Received: by 2002:a17:902:ea0c:b0:23d:f986:6472 with SMTP id
 d9443c01a7336-242fc287481mr14184195ad.25.1754951003328; Mon, 11 Aug 2025
 15:23:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: audit@vger.kernel.org
List-Id: <audit.vger.kernel.org>
List-Subscribe: <mailto:audit+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:audit+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a18a0b1af0ccca1fc56a8e82f02d5e4ab36149c.1754063834.git.rgb@redhat.com>
 <74767dff9834360b2100907df5142ab9@paul-moore.com> <aJSyXpsVfU+PfFzN@madcap2.tricolour.ca>
In-Reply-To: <aJSyXpsVfU+PfFzN@madcap2.tricolour.ca>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 11 Aug 2025 18:23:10 -0400
X-Gm-Features: Ac12FXzlcanNoS7j2e973OwKiT9rlNsc4IrrFZzGeXXhu4-6krmOTM7sf1LTA6A
Message-ID: <CAHC9VhQY_0wm_Wz7HD0wv0Xc_Pikv3FNtw4_ppGSYLyyKdFJWA@mail.gmail.com>
Subject: Re: [PATCH v2] audit: record fanotify event regardless of presence of rules
To: Richard Guy Briggs <rgb@redhat.com>
Cc: Linux-Audit Mailing List <linux-audit@lists.linux-audit.osci.io>, 
	LKML <linux-kernel@vger.kernel.org>, linux-fsdevel@vger.kernel.org, 
	Linux Kernel Audit Mailing List <audit@vger.kernel.org>, Eric Paris <eparis@parisplace.org>, 
	Steve Grubb <sgrubb@redhat.com>, Jan Kara <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 7, 2025 at 10:04=E2=80=AFAM Richard Guy Briggs <rgb@redhat.com>=
 wrote:
> On 2025-08-06 21:47, Paul Moore wrote:
> > On Aug  6, 2025 Richard Guy Briggs <rgb@redhat.com> wrote:
> > >
> > > When no audit rules are in place, fanotify event results are
> > > unconditionally dropped due to an explicit check for the existence of
> > > any audit rules.  Given this is a report from another security
> > > sub-system, allow it to be recorded regardless of the existence of an=
y
> > > audit rules.
> > >
> > > To test, install and run the fapolicyd daemon with default config.  T=
hen
> > > as an unprivileged user, create and run a very simple binary that sho=
uld
> > > be denied.  Then check for an event with
> > >     ausearch -m FANOTIFY -ts recent
> > >
> > > Link: https://issues.redhat.com/browse/RHEL-9065
> > > Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> > > ---
> > > changelog:
> > > v2
> > > - re-add audit_enabled check
> > > ---
> > >  include/linux/audit.h | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > Merged into audit/dev-staging with the plan being to merge it to
> > audit/dev once the merge window closes.
>
> Thanks Paul.

Now merged into audit/dev, thanks!

--=20
paul-moore.com
